class TutorialModel {
  final String videoId;
  final String title;
  final List<String> materials;
  final List<String> purposes;
  final String instructions;
  final String username;
  final String uid;
  final String avatar;
  final List<String> likes;
  final String createdAt;
  final String id;

  const TutorialModel({
    required this.videoId,
    required this.title,
    required this.materials,
    required this.instructions,
    required this.purposes,
    required this.username,
    required this.uid,
    required this.avatar,
    required this.likes,
    required this.createdAt,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'videoId': videoId,
      'title': title,
      'materials': materials,
      'purposes': purposes,
      'instructions': instructions,
      'username': username,
      'uid': uid,
      'avatar': avatar,
      'likes': likes,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory TutorialModel.fromMap(Map<String, dynamic> data) {
    return TutorialModel(
      videoId: data['videoId'],
      title: data['title'],
      materials: List<String>.from(data['materials']),
      purposes: List<String>.from(data['purposes']),
      instructions: data['instructions'],
      username: data['username'],
      uid: data['uid'],
      avatar: data['avatar'],
      likes: List<String>.from(data['likes']),
      createdAt: data['createdAt'],
      id: data['id'],
    );
  }
}
