import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';

class SingleBlogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;

  const SingleBlogWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.author,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogDetailsScreen(
          title: title,
          content: content,
          author: author,
          image: image,
        )));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                height: 200, // Adjusted height for the image
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'By $author',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
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
