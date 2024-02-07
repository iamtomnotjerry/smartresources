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
    final tutorials = await _firestore
        .collection('blogs')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return tutorials.docs
        .map((tutorial) => BlogModel.fromMap(tutorial.data()))
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

    final tutorials = await query.get();

    print('------------' + tutorials.toString());

    return tutorials.docs
        .map((tutorial) => BlogModel.fromMap(tutorial.data()))
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
}
