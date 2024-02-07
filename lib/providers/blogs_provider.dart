import 'package:flutter/material.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/services/blog_service.dart';

class BlogsProvider extends ChangeNotifier {
  List<BlogModel> blogs = [];

  void refreshBlogs() async {
    blogs = await BlogsService().getBlogs();
    notifyListeners();
  }
}
