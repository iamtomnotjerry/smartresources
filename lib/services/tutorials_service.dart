import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';

class TutorialService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addTutorial(TutorialModel data) async {
    await _firestore.collection('tutorials').doc(data.id).set(
          data.toJson(),
        );
  }

  Future<List<TutorialModel>> getTutorials() async {
    final tutorials = await _firestore
        .collection('tutorials')
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    return tutorials.docs
        .map((tutorial) => TutorialModel.fromMap(tutorial.data()))
        .toList();
  }

  Future<List<TutorialModel>> getTutorialsWithPagination({
    int page = 1,
    int limit = 10,
    String? lastVisibleId,
  }) async {
    var query = _firestore
        .collection('tutorials')
        .orderBy('createdAt', descending: true);

    if (lastVisibleId != null) {
      final lastVisibleSnapshot =
          await _firestore.collection('tutorials').doc(lastVisibleId).get();
      query = query.startAfterDocument(lastVisibleSnapshot);
    }

    query = query.limit(limit);

    final tutorials = await query.get();

    print('------------$tutorials');

    return tutorials.docs
        .map((tutorial) => TutorialModel.fromMap(tutorial.data()))
        .toList();
  }

  Future<List<TutorialModel>>searchTutorials(String searchTerm) async{
    var query = _firestore.collection('tutorials').orderBy('title', descending: true);
    query = query.where('title', isGreaterThanOrEqualTo: searchTerm);
    query = query.where('title', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    final products = await query.get();
    return products.docs.map((blog) => TutorialModel.fromMap(blog.data())).toList();
  }

  Future<void> updateTutorial(TutorialModel data) async {
    await _firestore.collection('tutorials').doc(data.id).update(
          data.toJson(),
        );
  }

  Future<void> deleteTutorial(String id) async {
    await _firestore.collection('tutorials').doc(id).delete();
  }

  Future<void> like(String id, String uid) async {
    await _firestore.collection('tutorials').doc(id).update({
      'likes': FieldValue.arrayUnion([uid]),
    });
  }

  Future<void> unlike(String id, String uid) async {
    await _firestore.collection('tutorials').doc(id).update({
      'likes': FieldValue.arrayRemove([uid]),
    });
  }
}
