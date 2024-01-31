import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Navigator(
  //       key: navigatorKey,
  //       onGenerateRoute: (settings) {
  //         return MaterialPageRoute(
  //           settings: settings,
  //           builder: (context) => _buildProfileScreenContent(context),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 85.v),
              _buildPlaylist(context),
              SizedBox(height: 40.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 27.h),
                  child: Text(
                    "My Account",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 5.v),
              _buildReviews(context),
              SizedBox(height: 51.v),
              _buildDoctorReviews(context),
              const Spacer(),
              // _buildRecentOrders(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      );
  }

  /// Section Widget
  Widget _buildPlaylist(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 27.h,
        vertical: 20.v,
      ),
      decoration: AppDecoration.fillGreen300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      child: Row(
        children: [
          Container(
            height: 80.adaptSize,
            width: 80.adaptSize,
            margin: EdgeInsets.only(top: 2.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgUnsplashZhvm3xiohoe,
                  height: 80.adaptSize,
                  width: 80.adaptSize,
                  radius: BorderRadius.circular(
                    40.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 18.adaptSize,
                    width: 18.adaptSize,
                    margin: EdgeInsets.only(
                      right: 5.h,
                      bottom: 1.v,
                    ),
                    decoration:
                        AppDecoration.outlineOnPrimaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder8,
                    ),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgEditOnprimarycontainer,
                      height: 18.adaptSize,
                      width: 18.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 19.h,
              top: 31.v,
              bottom: 28.v,
            ),
            child: Text(
              "Esther Hosward",
              style: CustomTextStyles.titleMediumOnPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildReviews(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 27.h,
        right: 21.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 24.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildClientTestimonials(
            context,
            infoImage: ImageConstant.imgUser,
            purchasedHistory: "My orders",
          ),
          SizedBox(height: 28.v),
          _buildClientTestimonials(
            context,
            infoImage: ImageConstant.imgInfo,
            purchasedHistory: "Purchased history",
          ),
          SizedBox(height: 28.v),
          _buildClientTestimonials(
            context,
            infoImage: ImageConstant.imgLockPrimary,
            purchasedHistory: "Recently viewed",
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDoctorReviews(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 27.h,
        right: 21.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 24.v,
      ),
      decoration: AppDecoration.outlineBlack9001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildClientTestimonials(
            context,
            infoImage: ImageConstant.imgInfoPrimary,
            purchasedHistory: "Account Settings",
          ),
          SizedBox(height: 28.v),
          Container(
            decoration: AppDecoration.outlineGray,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 144.h,
                  margin: EdgeInsets.only(bottom: 16.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgInbox,
                        height: 28.adaptSize,
                        width: 28.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.v,
                          bottom: 2.v,
                        ),
                        child: Text(
                          "Help Center",
                          style: CustomTextStyles.titleMediumBlack900,
                        ),
                      ),
                    ],
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgArrowRightPrimary,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(
                    top: 6.v,
                    bottom: 22.v,
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
  // Widget _buildRecentOrders(BuildContext context) {
  //   return Container(
  //     width: double.maxFinite,
  //     padding: EdgeInsets.symmetric(
  //       horizontal: 40.h,
  //       vertical: 18.v,
  //     ),
  //     decoration: AppDecoration.outlineBlueGray,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           height: 40.v,
  //           width: 29.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 29.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 2.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgHome,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Home",
  //                   style: CustomTextStyles.labelMediumPrimary,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 40.v,
  //           width: 42.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               CustomIconButton(
  //                 height: 40.v,
  //                 width: 42.h,
  //                 alignment: Alignment.center,
  //                 child: CustomImageView(
  //                   imagePath: ImageConstant.imgForward,
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Tutorials",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 41.v,
  //           width: 27.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 27.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 1.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgTelevision,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Blogs",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 41.v,
  //           width: 25.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.topCenter,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 25.h,
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgThumbsUp,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Shop",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           height: 40.v,
  //           width: 31.h,
  //           margin: EdgeInsets.only(top: 1.v),
  //           child: Stack(
  //             alignment: Alignment.bottomCenter,
  //             children: [
  //               Align(
  //                 alignment: Alignment.center,
  //                 child: Container(
  //                   height: 40.v,
  //                   width: 31.h,
  //                   padding: EdgeInsets.symmetric(horizontal: 3.h),
  //                   decoration: AppDecoration.fillOnPrimaryContainer,
  //                   child: CustomImageView(
  //                     imagePath: ImageConstant.imgLock,
  //                     height: 24.adaptSize,
  //                     width: 24.adaptSize,
  //                     alignment: Alignment.topCenter,
  //                   ),
  //                 ),
  //               ),
  //               Align(
  //                 alignment: Alignment.bottomCenter,
  //                 child: Text(
  //                   "Profile",
  //                   style: theme.textTheme.labelMedium,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  /// Section Widget
  // Widget _buildUserProfile(BuildContext context) {
  //   return CustomBottomBar(
  //     onChanged: (BottomBarEnum type) {},
  //   );
  // }
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
      currentIndex: 4,
    );
  }

  /// Common widget
  Widget _buildClientTestimonials(
    BuildContext context, {
    required String infoImage,
    required String purchasedHistory,
  }) {
    return GestureDetector(
      onTap: () {},
      child:Container (
      decoration: AppDecoration.outlineGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: infoImage,
            height: 28.adaptSize,
            width: 28.adaptSize,
            margin: EdgeInsets.only(bottom: 16.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 5.v,
              bottom: 18.v,
            ),
            child: Text(
              purchasedHistory,
              style: CustomTextStyles.titleMediumBlack900.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
          const Spacer(),
          CustomImageView(
            imagePath: ImageConstant.imgArrowRightPrimary,
            height: 16.adaptSize,
            width: 16.adaptSize,
            margin: EdgeInsets.only(
              top: 6.v,
              bottom: 22.v,
            ),
          ),
        ],
      ),
    ),);
  }
}
