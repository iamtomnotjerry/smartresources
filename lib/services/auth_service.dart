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

  Future<void> updateProfile({
    required String uid,
    required String name,
    Uint8List? avatar,
    required String dateOfBirth,
    required String phoneNumber,
    required String gender,
    bool avatarChanged = true,
  }) async {
    String _avatar = '';
    if (avatar != null && avatarChanged) {
      final ref = _storage.ref().child('avatars').child(uid);
      final uploadTask = ref.putData(avatar);
      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      _avatar = url;
    }

    if (avatarChanged) {
      await _firestore.collection('users').doc(uid).update({
        'name': name,
        'avatar': _avatar,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    } else {
      await _firestore.collection('users').doc(uid).update({
        'name': name,
        'dateOfBirth': dateOfBirth,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    }
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

      dynamic birthday = userData['birthday'].toString().split('/');
      birthday = '${birthday[2]}-${birthday[0]}-${birthday[1]}';

      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': userData['email'],
        'name': userData['name'],
        'avatar': userData['picture']['data']['url'],
        'dateOfBirth': birthday,
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

    String gender = '';
    if (response['gender'] != null) {
      gender =
          response["genders"][0]["formattedValue"].toString().toLowerCase();
    }
    String birthdays = '';
    if (response["birthdays"] != null) {
      final _birthdays = response["birthdays"][0]["date"];
      birthdays =
          "${_birthdays['year']}-${_birthdays['month']}-${_birthdays['day']} 00:00:00.000";
    }
    String phoneNumber = '';
    if (response["phoneNumbers"] != null) {
      phoneNumber = response["phoneNumbers"][0]["value"];
    }

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': userCredential.additionalUserInfo!.profile!['email'],
      'name': userCredential.user!.displayName,
      'avatar': userCredential.user!.photoURL,
      'dateOfBirth': birthdays,
      'gender': gender,
      'phoneNumber': phoneNumber,
    });
  }

  void signOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _auth.signOut();

              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.signInScreen);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
