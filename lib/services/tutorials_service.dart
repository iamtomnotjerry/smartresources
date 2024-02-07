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
    var query = await _firestore
        .collection('tutorials')
        .orderBy('createdAt', descending: true);

    if (lastVisibleId != null) {
      final lastVisibleSnapshot =
          await _firestore.collection('tutorials').doc(lastVisibleId).get();
      query = query.startAfterDocument(lastVisibleSnapshot);
    }

    query = await query.limit(limit);

    final tutorials = await query.get();

    print('------------' + tutorials.toString());

    return tutorials.docs
        .map((tutorial) => TutorialModel.fromMap(tutorial.data()))
        .toList();
  }

  Future<void> updateTutorial(TutorialModel data) async {
    await _firestore.collection('tutorials').doc(data.id).update(
          data.toJson(),
        );
  }

  Future<void> deleteTutorial(String id) async {
    await _firestore.collection('tutorials').doc(id).delete();
  }
}
