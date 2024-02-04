class UserModel {
  final String uid;
  final String email;
  final String name;
  final String avatar;
  final String phoneNumber;
  final String gender;
  final String dateOfBirth;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'avatar': avatar,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'],
      name: data['name'] ?? 'Default Name',
      avatar: data['avatar'] ?? 'avatar',
      phoneNumber: data['phoneNumber'] ?? 'phoneNumber',
      gender: data['gender'] ?? 'gender',
      dateOfBirth: data['dateOfBirth'] ?? 'dateOfBirth',
    );
  }
}
