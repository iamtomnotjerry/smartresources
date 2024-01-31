import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 24.h,
            top: 69.v,
            right: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.h),
                child: Text(
                  "Account Settings",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 49.v),
              _buildSettingsFrame(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildSettingsFrame(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 24.v,
      ),
      decoration: AppDecoration.shadow.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeleteAccountFrame(
            context,
            thumbsUpImage: ImageConstant.imgContrast,
            deleteAccountText: "Change Password",
          ),
          SizedBox(height: 28.v),
          _buildDeleteAccountFrame(
            context,
            thumbsUpImage: ImageConstant.imgThumbsUpPrimary,
            deleteAccountText: "Delete Account",
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {},
    );
  }

  /// Common widget
  Widget _buildDeleteAccountFrame(
    BuildContext context, {
    required String thumbsUpImage,
    required String deleteAccountText,
  }) {
    return Container(
      decoration: AppDecoration.outlineBluegray50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: thumbsUpImage,
            height: 28.adaptSize,
            width: 28.adaptSize,
            margin: EdgeInsets.only(bottom: 16.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 3.v,
              bottom: 20.v,
            ),
            child: Text(
              deleteAccountText,
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
    );
  }
}
