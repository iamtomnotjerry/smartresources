import 'package:flutter/material.dart';
import 'package:smartresource/data/models/tutorial/tutorial_model.dart';
import 'package:smartresource/services/tutorials_service.dart';

class TutorialsProvider extends ChangeNotifier {
  List<TutorialModel> tutorials = [];

  void refreshTutorials() async {
    tutorials = await TutorialService().getTutorials();
    notifyListeners();
  }
}
