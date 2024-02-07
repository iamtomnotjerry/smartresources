import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';

class SingleBlogWidget extends StatelessWidget {
  final BlogModel blog;

  const SingleBlogWidget({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 32,
        top: 24,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.blueGrey.shade50,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlogDetailsScreen(
                blog: blog,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  image: NetworkImage(blog.thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              blog.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              blog.content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: blog.avatar.isNotEmpty
                          ? NetworkImage(blog.avatar)
                          : AssetImage(ImageConstant.avatarPlaceholder)
                              as ImageProvider,
                      radius: 18,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.username,
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          DateTime.parse(blog.createdAt).format(),
                          style: TextStyle(
                            color: Colors.blueGrey.shade500,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 18,
                      color: Colors.blueGrey.shade200,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      blog.likes.length.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey.shade500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
