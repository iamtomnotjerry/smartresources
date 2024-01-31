import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController newPasswordSectionController = TextEditingController();

  TextEditingController confirmNewPasswordSectionController =
      TextEditingController();

  TextEditingController currentPasswordSectionController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
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
                        "Change Password",
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: 44.v),
                    _buildFrameOneSection(context),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationSection(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildNewPasswordSection(BuildContext context) {
    return CustomTextFormField(
      controller: newPasswordSectionController,
      hintText: "********",
      textInputType: TextInputType.visiblePassword,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 18.v, 24.h, 18.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgEye,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 56.v,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.only(
        left: 24.h,
        top: 18.v,
        bottom: 18.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmNewPasswordSection(BuildContext context) {
    return CustomTextFormField(
      controller: confirmNewPasswordSectionController,
      hintText: "********",
      textInputType: TextInputType.visiblePassword,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 18.v, 24.h, 18.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgEye,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 56.v,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.only(
        left: 24.h,
        top: 18.v,
        bottom: 18.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildCurrentPasswordSection(BuildContext context) {
    return CustomTextFormField(
      controller: currentPasswordSectionController,
      hintText: "********",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      suffix: Container(
        margin: EdgeInsets.fromLTRB(30.h, 18.v, 24.h, 18.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgEye,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(
        maxHeight: 56.v,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.only(
        left: 24.h,
        top: 18.v,
        bottom: 18.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameOneSection(BuildContext context) {
    return SizedBox(
      height: 301.v,
      width: 382.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: AppDecoration.outlineBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 118.v),
                  Text(
                    "New Password",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 7.v),
                  _buildNewPasswordSection(context),
                  SizedBox(height: 15.v),
                  Text(
                    "Confirm New Password",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 7.v),
                  _buildConfirmNewPasswordSection(context),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Password",
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 7.v),
                _buildCurrentPasswordSection(context),
                SizedBox(height: 5.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot password?",
                    style: CustomTextStyles.bodyMediumPrimary.copyWith(
                      decoration: TextDecoration.underline,
                    ),
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
  Widget _buildChangePasswordButtonSection(BuildContext context) {
    return const CustomElevatedButton(
      text: "Change Password",
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 32.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: _buildChangePasswordButtonSection(context),
    );
  }
}
