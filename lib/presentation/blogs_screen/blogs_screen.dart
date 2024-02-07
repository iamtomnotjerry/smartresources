import 'package:flutter/material.dart' hide SearchBar;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/presentation/blogs_screen/widgets/single_blog.dart';
import 'package:smartresource/widgets/search_bar.dart';

class BlogsScreen extends StatelessWidget {
  BlogsScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return CircularProgressIndicator(); // Placeholder for loading state
                    default:
                      return Column(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          return SingleBlogWidget(
                            title: data['title'] ?? '',
                            content: data['content'] ?? '',
                            author: data['userEmail'] ?? '',
                            image: data['thumbnail'] ?? '',
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
