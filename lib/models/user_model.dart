class UserModel {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final String dataOfBirth;
  final String phoneNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.avatar,
    required this.dataOfBirth,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'dataOfBirth': dataOfBirth,
      'phoneNumber': phoneNumber,
    };
  }
}
