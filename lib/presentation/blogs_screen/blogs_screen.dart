import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/data/data_sources/blog/blog_source.dart';
import 'package:smartresource/data/models/blog/blog_model.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_search_view.dart';

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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child:Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 23.h),
          child: Column(
            children: [
              SizedBox(height: 51.v),
              _buildBlogsFrame(context),
              SizedBox(height: 27.v),
              _buildSearchBar(context),
              SizedBox(height: 33.v),
              Container(
                margin: EdgeInsets.only(left: 1.h),
                decoration: AppDecoration.outlineBlack,
                child: ListView.builder(itemCount: blogList.length, physics: const ScrollPhysics(), shrinkWrap: true, itemBuilder: (context, index) {
                  BlogModel blogItem = blogList[index];
                  return _buildFrameFortyOne(context, title: blogItem.title, content: blogItem.content, author: blogItem.author, image: blogItem.image);
                })
              ),
            ],
          ),
        ),),
        bottomNavigationBar: _buildBottomBar(context),
      );
  }

  /// Section Widget
  Widget _buildBlogsFrame(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              "Blogs",
              style: CustomTextStyles.headlineSmallPrimary,
            ),
          ),
          CustomIconButton(
            height: 32.v,
            width: 40.h,
            padding: EdgeInsets.all(8.h),
            decoration: IconButtonStyleHelper.fillBlueGrayTL10,
            child: CustomImageView(
              imagePath: ImageConstant.imgEdit,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: CustomSearchView(
            controller: searchController,
            hintText: "Search",
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(12.h),
            decoration: IconButtonStyleHelper.fillPrimaryTL12,
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 2,
    );
  }

  /// Common widget
  Widget _buildFrameFortyOne(
    BuildContext context, {
    required String title,
    required String content,
    required String author,
    required String image,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailsScreen(
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
