import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/services/blog_service.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blog;

  const BlogDetailsScreen({
    super.key,
    required this.blog,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  late List<String> _likes;

  @override
  void initState() {
    super.initState();
    _likes = widget.blog.likes;
  }

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
          widget.blog.uid == FirebaseAuth.instance.currentUser!.uid
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
                              blog: widget.blog,
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
                                      widget.blog.id,
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
                widget.blog.thumbnail,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.blog.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: widget.blog.avatar.isNotEmpty
                                ? NetworkImage(widget.blog.avatar)
                                : AssetImage(ImageConstant.avatarPlaceholder)
                                    as ImageProvider,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.blog.username,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                DateTime.parse(widget.blog.createdAt).format(),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (_likes.contains(
                                  FirebaseAuth.instance.currentUser!.uid,
                                )) {
                                  BlogsService().unlike(
                                    widget.blog.id,
                                    FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  setState(() {
                                    _likes.remove(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    );
                                  });
                                } else {
                                  BlogsService().like(
                                    widget.blog.id,
                                    FirebaseAuth.instance.currentUser!.uid,
                                  );
                                  setState(() {
                                    _likes.add(
                                      FirebaseAuth.instance.currentUser!.uid,
                                    );
                                  });
                                }
                              },
                              child: _likes.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_outline_rounded,
                                      color: appTheme.blueGray200,
                                    )),
                          const SizedBox(width: 8),
                          Text(
                            _likes.length.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: appTheme.gray600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.more_vert,
                            color: appTheme.gray600,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.blog.content,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey.shade700,
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
