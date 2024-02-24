import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/data/models/user/user_model.dart';

class UsersService {
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    // await FirebaseAuth.instance.signOut();
    return UserModel.fromMap(snapshot.data()!);
  }
}
