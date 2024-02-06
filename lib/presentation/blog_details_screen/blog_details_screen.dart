import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';

class BlogDetailsScreen extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String image;

  const BlogDetailsScreen({super.key, required this.title, required this.content, required this.author, required this.image});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(
            'Blog',
            style: TextStyle(
              color: theme.colorScheme.primary,
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildImageStack(context),
                SizedBox(height: 23.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 362.h,
                    margin: EdgeInsets.only(
                      left: 24.h,
                      right: 43.h,
                    ),
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.titleLargeBluegray70001,
                    ),
                  ),
                ),
                SizedBox(height: 5.v),
                _buildRowFrameSixtySeven(context),
                SizedBox(height: 25.v),
                SizedBox(
                  height: 563.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 382.h,
                          child: Text(
                            content,
                            maxLines: 24,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: CustomTextStyles.bodyLargeBlack900.copyWith(
                              height: 1.50,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 12.v,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(bottom: 4.v),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildImageStack(BuildContext context) {
    return SizedBox(
      height: 240.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomImageView(
            imagePath: image,
            height: 240.v,
            width: 430.h,
            radius: BorderRadius.circular(
              8.h,
            ),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowFrameSixtySeven(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
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
                  text: author,
                  style: CustomTextStyles.bodyMediumff52b788,
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            "21/1/2024",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
