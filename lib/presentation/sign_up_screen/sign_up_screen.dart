import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_checkbox_button.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  bool agreeWithTerm = false;

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
                    _buildFrameTen(context),
                    SizedBox(height: 21.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Name",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildName(context),
                    SizedBox(height: 11.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Email",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildEmail(context),
                    SizedBox(height: 11.v),
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
                    SizedBox(height: 11.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Confirm Password",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildConfirmPassword(context),
                    SizedBox(height: 10.v),
                    _buildAgreeWithTerm(context),
                    SizedBox(height: 28.v),
                    _buildSignUp(context),
                    SizedBox(height: 13.v),
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
                            "Or sign up with",
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
                    SizedBox(height: 19.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildGoogle(context),
                        _buildFacebook(context),
                      ],
                    ),
                    SizedBox(height: 41.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: CustomTextStyles.bodyMediumff495057,
                          ),
                          TextSpan(
                            text: "Sign in",
                            style: CustomTextStyles.titleSmallff52b788,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 5.v),
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
  Widget _buildFrameTen(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: fs.Svg(
            ImageConstant.imgFrame10,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse1,
                  height: 114.v,
                  width: 146.h,
                  margin: EdgeInsets.only(bottom: 25.v),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgSettings,
                  height: 45.adaptSize,
                  width: 45.adaptSize,
                  margin: EdgeInsets.only(
                    left: 45.h,
                    top: 94.v,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 21.v),
          Text(
            "Sign Up",
            style: theme.textTheme.headlineLarge,
          ),
          SizedBox(height: 12.v),
          Text(
            "Let’s create your account!",
            style: CustomTextStyles.bodyLargeOnPrimaryContainer,
          ),
          SizedBox(height: 17.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: nameController,
        hintText: "John Doe",
      ),
    );
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: emailController,
        hintText: "example@gmail.com",
        textInputType: TextInputType.emailAddress,
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
  Widget _buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: confirmPasswordController,
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
  Widget _buildAgreeWithTerm(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 24.h),
        child: CustomCheckboxButton(
          alignment: Alignment.centerLeft,
          text: "Agree with Term & condition.",
          value: agreeWithTerm,
          onChange: (value) {
            agreeWithTerm = value;
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      height: 56.v,
      text: "Sign Up",
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      buttonStyle: CustomButtonStyles.fillPrimary,
      buttonTextStyle: CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
    );
  }

  /// Section Widget
  Widget _buildGoogle(BuildContext context) {
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
  Widget _buildFacebook(BuildContext context) {
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
