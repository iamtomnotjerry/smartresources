import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';

import '../home_screen/widgets/playlist_item_widget.dart';
import '../home_screen/widgets/recentorders_item_widget.dart';
import '../home_screen/widgets/reviews_item_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  // Widget build (BuildContext context) {
  //   return SafeArea(
  //     child: Navigator(
  //       key: navigatorKey,
  //       onGenerateRoute: (settings) {
  //         return MaterialPageRoute(
  //           settings: settings,
  //           builder: (context) => _buildHomeScreenContent(context),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 62.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h),
                    child: Text(
                      "Discover",
                      style: CustomTextStyles.headlineLargePrimary,
                    ),
                  ),
                ),
                SizedBox(height: 15.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: _buildClientTestimonials(context,
                      blogTitle: "Tutorials",
                      seeAllText: "See all",
                      route: AppRoutes.tutorialsScreen),
                ),
                SizedBox(height: 9.v),
                _buildPlaylist(context),
                SizedBox(height: 15.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: _buildClientTestimonials(context,
                      blogTitle: "Blogs",
                      seeAllText: "See all",
                      route: AppRoutes.blogsScreen),
                ),
                SizedBox(height: 7.v),
                _buildReviews(context),
                SizedBox(height: 12.v),
                _buildDoctorReviews(context),
                SizedBox(height: 9.v),
                _buildRecentOrders(context),
              ],
            ),
          )),
    );
  }

  /// Section Widget
  Widget _buildPlaylist(BuildContext context) {
    return SizedBox(
      height: 195.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 24.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 14.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return const PlaylistItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildReviews(BuildContext context) {
    return SizedBox(
      height: 197.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 24.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 14.h,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return const ReviewsItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildDoctorReviews(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: 24.h,
          right: 45.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Products",
              style: CustomTextStyles.titleMediumBlack90018,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 2.v),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.shopScreen);
                  },
                  child: Text(
                    "See all",
                    style: CustomTextStyles.titleSmallPrimary,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentOrders(BuildContext context) {
    return SizedBox(
      height: 212.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 24.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 14.h,
          );
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return const RecentordersItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 40.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.outlineBlueGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40.v,
            width: 29.h,
            margin: EdgeInsets.only(top: 1.v),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40.v,
                    width: 29.h,
                    padding: EdgeInsets.symmetric(horizontal: 2.h),
                    decoration: AppDecoration.fillOnPrimaryContainer,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgHome,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Home",
                    style: CustomTextStyles.labelMediumPrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40.v,
            width: 42.h,
            margin: EdgeInsets.only(top: 1.v),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomIconButton(
                  height: 40.v,
                  width: 42.h,
                  alignment: Alignment.center,
                  child: CustomImageView(
                    imagePath: ImageConstant.imgForward,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Tutorials",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 41.v,
            width: 27.h,
            margin: EdgeInsets.only(top: 1.v),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 40.v,
                    width: 27.h,
                    padding: EdgeInsets.symmetric(horizontal: 1.h),
                    decoration: AppDecoration.fillOnPrimaryContainer,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgTelevision,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Blogs",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 41.v,
            width: 25.h,
            margin: EdgeInsets.only(top: 1.v),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 40.v,
                    width: 25.h,
                    decoration: AppDecoration.fillOnPrimaryContainer,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgThumbsUp,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Shop",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40.v,
            width: 31.h,
            margin: EdgeInsets.only(top: 1.v),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40.v,
                    width: 31.h,
                    padding: EdgeInsets.symmetric(horizontal: 3.h),
                    decoration: AppDecoration.fillOnPrimaryContainer,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Profile",
                    style: theme.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 0,
    );
  }

  /// Common widget
  Widget _buildClientTestimonials(
    BuildContext context, {
    required String blogTitle,
    required String seeAllText,
    required String route,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          blogTitle,
          style: CustomTextStyles.titleMediumBlack90018.copyWith(
            color: appTheme.black900,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, route);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 4.v),
            child: Text(
              seeAllText,
              style: CustomTextStyles.titleSmallPrimary.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        )
      ],
    );
  }
}
