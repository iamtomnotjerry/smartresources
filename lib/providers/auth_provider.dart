import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/data/models/user/user_model.dart';
import 'package:smartresource/services/users_service.dart';

class MyAuthProvider extends ChangeNotifier {
  UserModel? user;

  Future<void> refreshUser() async {
    user = await UsersService().getUser(FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }
}
