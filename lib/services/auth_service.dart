import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:smartresource/core/app_export.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<Map<String, String>> signUp({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user!.sendEmailVerification();

    final user = {'email': email, 'uid': credential.user!.uid};

    await _firestore.collection('users').doc(credential.user!.uid).set(
          user,
        );

    return user;
  }

  Future<void> completeProfile({
    required String uid,
    required String name,
    Uint8List? avatar,
    required String dateOfBirth,
    required String phoneNumber,
    required String gender,
  }) async {
    String _avatar = '';
    if (avatar != null) {
      final ref = _storage.ref().child('avatars').child(uid);
      final uploadTask = ref.putData(avatar);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      _avatar = url;
    }

    await _firestore.collection('users').doc(uid).update({
      'name': name,
      'avatar': _avatar,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'gender': gender,
    });
  }

  Future<void> signInWithFacebook() async {
    final result = await FacebookAuth.i.login(
      permissions: [
        'email',
        'public_profile',
        'user_birthday',
        'user_gender',
      ],
    );
    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final userData = await FacebookAuth.i.getUserData(
        fields: "name,email,picture.width(200),birthday,gender",
      );

      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userData['email'],
        'name': userData['name'],
        'avatar': userData['picture']['data']['url'],
        'dateOfBirth': userData['birthday'],
        'gender': userData['gender'],
      });
    }
  }

  Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(scopes: [
      'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/user.gender.read',
      'https://www.googleapis.com/auth/user.phonenumbers.read',
    ]);

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final headers = await googleSignIn.currentUser!.authHeaders;
    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=genders,birthdays,phoneNumbers,&key="),
        headers: {"Authorization": headers["Authorization"] as String});
    final response = json.decode(r.body);
    final String gender =
        response["genders"][0]["formattedValue"].toString().toLowerCase();
    final Map<String, dynamic> birthdays = response["birthdays"][0]["date"];
    String phoneNumber = '';
    if (response["phoneNumbers"] != null) {
      phoneNumber = response["phoneNumbers"][0]["value"];
    }

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.additionalUserInfo!.profile!['email'],
      'name': userCredential.user!.displayName,
      'avatar': userCredential.user!.photoURL,
      'dateOfBirth':
          "${birthdays['year']}-${birthdays['month']}-${birthdays['day']} 00:00:00.000",
      'gender': gender,
      'phoneNumber': phoneNumber,
    });
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.of(context).pushReplacementNamed(AppRoutes.signInScreen);
  }
}
