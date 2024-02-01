import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
}
