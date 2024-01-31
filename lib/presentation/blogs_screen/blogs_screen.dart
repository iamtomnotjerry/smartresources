import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
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
  // Widget build (BuildContext context) {
  //   return SafeArea(
  //     child: Navigator(
  //       key: navigatorKey,
  //       onGenerateRoute: (settings) {
  //         return MaterialPageRoute(
  //           settings: settings,
  //           builder: (context) => _buildBlogScreenContent(context),
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
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
                child: Column(
                  children: [
                    _buildFrameFortyOne(
                      context,
                      thCHNhKhNg:
                          "Thực hành không rác thải - Chúng ta đã thực sự hiểu?",
                      authorAnonymous: "Author: Anonymous",
                      twoMillionSixHundredTwelveThou: "26/1/2024",
                    ),
                    SizedBox(height: 24.v),
                    _buildFrameFortyOne(
                      context,
                      thCHNhKhNg:
                          "Thực hành không rác thải - Chúng ta đã thực sự hiểu?",
                      authorAnonymous: "Author: Anonymous",
                      twoMillionSixHundredTwelveThou: "26/1/2024",
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
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
            child: CustomImageView(
              imagePath: ImageConstant.imgTune,
            ),
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
    required String thCHNhKhNg,
    required String authorAnonymous,
    required String twoMillionSixHundredTwelveThou,
  }) {
    return Container(
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnsplashX8zstuks2pm,
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
              thCHNhKhNg,
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
                        text: "Anonymous",
                        style: CustomTextStyles.titleSmallff52b788,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  twoMillionSixHundredTwelveThou,
                  style: CustomTextStyles.bodyMediumGray600.copyWith(
                    color: appTheme.gray600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.v),
        ],
      ),
    );
  }
}
