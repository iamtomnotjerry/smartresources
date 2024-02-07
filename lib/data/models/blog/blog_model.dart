class BlogModel {
  final String thumbnail;
  final String title;
  final String content;
  final String username;
  final String uid;
  final String avatar;
  final List<String> likes;
  final String createdAt;
  final String id;

  BlogModel({
    required this.thumbnail,
    required this.title,
    required this.content,
    required this.username,
    required this.uid,
    required this.avatar,
    required this.likes,
    required this.createdAt,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'thumbnail': thumbnail,
      'title': title,
      'content': content,
      'username': username,
      'uid': uid,
      'avatar': avatar,
      'likes': likes,
      'createdAt': createdAt,
      'id': id,
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> json) {
    return BlogModel(
      thumbnail: json['thumbnail'],
      title: json['title'],
      content: json['content'],
      username: json['username'],
      uid: json['uid'],
      avatar: json['avatar'],
      likes: List<String>.from(json['likes']),
      createdAt: json['createdAt'],
      id: json['id'],
    );
  }
}
