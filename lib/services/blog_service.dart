import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';

class BlogsService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addBlog(BlogModel data) async {
    await _firestore.collection('blogs').doc(data.id).set(
          data.toJson(),
        );
  }
  
   Future<List<BlogModel>> getBlogs() async {
    final blogs = await _firestore
        .collection('blogs')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return blogs.docs
        .map((blog) => BlogModel.fromMap(blog.data()))
        .toList();
  }

   Future<List<BlogModel>> getBlogsWithPagination({
    int page = 1,
    int limit = 10,
    String? lastVisibleId,
  }) async {
    var query = await _firestore
        .collection('blogs')
        .orderBy('createdAt', descending: true);

    if (lastVisibleId != null) {
      final lastVisibleSnapshot =
          await _firestore.collection('blogs').doc(lastVisibleId).get();
      query = query.startAfterDocument(lastVisibleSnapshot);
    }

    query = await query.limit(limit);

    final blogs = await query.get();

    print('------------' + blogs.toString());

    return blogs.docs
        .map((blog) => BlogModel.fromMap(blog.data()))
        .toList();
  }

  Future<void> updateBlog(BlogModel data) async {
    await _firestore.collection('blogs').doc(data.id).update(
          data.toJson(),
        );
  }

  Future<void> deleteBlog(String id) async {
    await _firestore.collection('blogs').doc(id).delete();
  }

   Future<void> like(String id, String uid) async {
    await _firestore.collection('blogs').doc(id).update({
      'likes': FieldValue.arrayUnion([uid]),
    });
  }

  Future<void> unlike(String id, String uid) async {
    await _firestore.collection('blogs').doc(id).update({
      'likes': FieldValue.arrayRemove([uid]),
    });
  }
}
