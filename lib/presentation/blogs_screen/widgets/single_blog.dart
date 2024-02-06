import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';

class SingleBlogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;

  const SingleBlogWidget({super.key, required this.title, required this.content, required this.author, required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BlogDetailsScreen(
          title: title,
          content: content,
          author: author,
          image: image
        )));
      },
      child:Container(
      height: 400.v,
      // decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
      //   borderRadius: BorderRadiusStyle.roundedBorder12,
      // ),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(                                                                                                                                                                                             
        border: Border.all(
          color: Colors.grey, // Set border color here
          width: 2.0, // Set border width here
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: image,
            height: 217.v,
            width: 383.h,
          ),
          SizedBox(height: 17.v),
          Container(
            width: 343.h,
            margin: EdgeInsets.only(
              left: 16.h,
              right: 23.h,
            ),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.blueGray70001,
              ),
            ),
          ),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Author: ",
                        style: CustomTextStyles.bodyMediumff495057,
                      ),
                      TextSpan(
                        // text: "Anonymous",
                        text: author,
                        style: CustomTextStyles.titleSmallff52b788,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}