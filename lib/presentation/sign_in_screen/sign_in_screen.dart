import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_checkbox_button.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

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
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    _buildSettingsStack(context),
                    SizedBox(height: 40.v),
                    _buildInputWithLabelColumn(context),
                    SizedBox(height: 17.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Password",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildPassword(context),
                    SizedBox(height: 16.v),
                    _buildFrameThirteenRow(context),
                    SizedBox(height: 45.v),
                    _buildSignInButton(context),
                    SizedBox(height: 43.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 79.h,
                            child: const Divider(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12.h),
                          child: Text(
                            "Or sign in with",
                            style: CustomTextStyles.bodyMediumBluegray200,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 91.h,
                            child: Divider(
                              indent: 12.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildGoogleButton(context),
                        _buildFacebookButton(context),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(height: 17.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style: CustomTextStyles.bodyMediumff495057,
                          ),
                          TextSpan(
                            text: "Sign up",
                            style: CustomTextStyles.titleSmallff52b788,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSettingsStack(BuildContext context) {
    return Container(
      height: 250.v,
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgFrame10,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgEllipse1114x146,
            height: 114.v,
            width: 146.h,
            alignment: Alignment.topLeft,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 145.h,
                right: 145.h,
                bottom: 16.v,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgSettings,
                    height: 45.adaptSize,
                    width: 45.adaptSize,
                  ),
                  SizedBox(height: 21.v),
                  Text(
                    "Sign In",
                    style: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(height: 10.v),
                  Text(
                    "Hi! Welcome back!",
                    style: CustomTextStyles.bodyLargeOnPrimaryContainer,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "example@gmail.com",
      textInputType: TextInputType.emailAddress,
    );
  }

  /// Section Widget
  Widget _buildInputWithLabelColumn(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          _buildEmail(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: passwordController,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameThirteenRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckboxButton(
            text: "Remember me",
            value: rememberMe,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              rememberMe = value;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 3.v),
            child: Text(
              "Forgot password?",
              style: CustomTextStyles.titleSmallPrimary.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildSignInButton(BuildContext context) {
    return CustomElevatedButton(
      height: 56.v,
      text: "Sign In",
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
    );
  }

  /// Section Widget
  Widget _buildGoogleButton(BuildContext context) {
    return CustomElevatedButton(
      width: 127.h,
      text: "Google",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgGoogle,
          height: 21.v,
          width: 20.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: CustomTextStyles.titleSmallBlack900,
    );
  }

  /// Section Widget
  Widget _buildFacebookButton(BuildContext context) {
    return CustomElevatedButton(
      width: 136.h,
      text: "Facebook",
      margin: EdgeInsets.only(left: 24.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgFacebook,
          height: 21.v,
          width: 11.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillIndigo,
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimaryContainer,
    );
  }
}
