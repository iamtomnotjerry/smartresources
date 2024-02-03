import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';

// ignore: must_be_immutable
class BlogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;

  const BlogWidget({super.key, required this.title, required this.image, required this.content, required this.author});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailsScreen(
          title: title,
          content: content,
          author: author,
          image: image
        )));
      },
      child:SizedBox(
      width: 170.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.v),
        child: Column(
          children: [
            CustomImageView(
              imagePath: image,
              height: 134.v,
              width: 170.h,
              radius: BorderRadius.circular(
                10.h,
              ),
            ),
            SizedBox(height: 9.v),
            SizedBox(
              width: 170.h,
              child: Text(
                // "Lorem ipsum dolor sit amet, consectetur adipiscing",
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: theme.textTheme.titleSmall!.copyWith(
                  height: 1.14,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
