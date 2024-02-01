import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';

const List<BlogModel> blogList = [
  BlogModel(
    "This is my first post", 
    "To resolve these issues, you need to make sure that you're only using the const keyword with expressions that are truly constant.",
    "Jackie", 
    ImageConstant.imgUnsplashNovnxxmdni0
  ),
  BlogModel(
    "This is my second post",
    "If you share the specific code snippets where these errors occur, I can provide more targeted assistance.",
    "Tom", 
    ImageConstant.imgUnsplash76wEdo1u1e
  ),
  BlogModel(
    "This is my third post", 
    "Similar to the first error, it indicates that an element in a const list is not a constant expression. Ensure that all elements in a const list are themselves constants.",
    "Anonymous", 
    ImageConstant.imgUnsplashMhuk4se7pey
  )
];