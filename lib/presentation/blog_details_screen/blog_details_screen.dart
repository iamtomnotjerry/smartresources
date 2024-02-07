import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/services/blog_service.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogModel blog;

  const BlogDetailsScreen({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog',
          style: TextStyle(
            color: theme.colorScheme.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          blog.uid == FirebaseAuth.instance.currentUser!.uid
              ? PopupMenuButton(
                  offset: const Offset(0, 56),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddBlogScreen(
                              action: AddBlogAction.update,
                              blog: blog,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Blog'),
                              content: const Text(
                                'Are you sure you want to delete this blog?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlogsService().deleteBlog(
                                      blog.id,
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                )
              : const Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                blog.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By: ",
                              style: CustomTextStyles.bodyMediumff495057,
                            ),
                            TextSpan(
                              text: blog.username,
                              style: CustomTextStyles.bodyMediumff52b788,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        DateTime.parse(blog.createdAt).format(),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    blog.content,
                    style: TextStyle(
                      fontSize: 16,
                      color: appTheme.gray600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
