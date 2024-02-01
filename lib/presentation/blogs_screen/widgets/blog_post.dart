import 'package:flutter/material.dart';
import 'package:smartresource/core/utils/image_constant.dart';
import 'package:smartresource/theme/app_decoration.dart';
import 'package:smartresource/theme/custom_text_style.dart';
import 'package:smartresource/theme/theme_helper.dart';
import 'package:smartresource/widgets/custom_image_view.dart';

class BlogPost extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;

  const BlogPost({
    super.key, 
    required this.title, 
    required this.content, 
    required this.author, 
    required this.image
  });

  @override
  Widget build (BuildContext context) {
    return Container(
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: image,
            height: 217.0,
            width: 383.0,
          ),
          SizedBox(height: 17.0),
          Container(
            width: 343.0,
            margin: EdgeInsets.only(
              left: 16.0,
              right: 23.0,
            ),
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.blueGray70001,
              ),
            ),
          ),
          SizedBox(height: 9.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                Text(
                  title,
                  style: CustomTextStyles.bodyMediumGray600.copyWith(
                    color: appTheme.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}