import 'package:flutter/material.dart' hide SearchBar;
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/blog/blog_source.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';

import 'package:smartresource/presentation/blogs_screen/widgets/single_blog.dart';

import 'package:smartresource/widgets/search_bar.dart';
class BlogsScreen extends StatelessWidget {
  BlogsScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Blogs',
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBlogScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.add_rounded,
              size: 32,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Column(
            children: [
              const SizedBox(
                    height: 24,
                  ),
                  const SearchBar(),
                  const SizedBox(
                    height: 32,
                  ),
              Container(
                margin: EdgeInsets.only(left: 1.h),
                decoration: AppDecoration.outlineBlack,
                child: ListView.builder(itemCount: blogList.length, physics: const ScrollPhysics(), shrinkWrap: true, itemBuilder: (context, index) {
                  BlogModel blogItem = blogList[index];
                  return SingleBlogWidget(title: blogItem.title, content: blogItem.content, author: blogItem.author, image: blogItem.image);
                })
              ),
            ],
          ),
        ),
      ),
    );
  }
}