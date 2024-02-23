import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/navigation_menu.dart';
import 'package:smartresource/presentation/complete_profile_screen/complete_profile_screen.dart';
import 'package:smartresource/presentation/email_verification_screen/email_verification_screen.dart';
import 'package:smartresource/services/auth_service.dart';
import 'package:smartresource/widgets/custom_checkbox_button.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agreeWithTerm = false;

  bool isLoading = false;

  bool _hidePassWord = true;

  bool _hideConfirmPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onFacebookSignIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      await AuthService().signInWithFacebook();

      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NavigationMenu(),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void onGoogleSignIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      await AuthService().signInWithGoogle();

      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NavigationMenu(),
        ),
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong.'),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (!agreeWithTerm) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree with term & condition.'),
          ),
        );
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });

        final user = await AuthService().signUp(
          email: emailController.text,
          password: passwordController.text,
        );

        setState(() {
          isLoading = false;
        });

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
              email: user['email'] as String,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CompleteProfileScreen(
                    uid: user['uid'] as String,
                  ),
                ),
              ),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account already exists for that email.'),
            ),
          );
        }

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong.'),
          ),
        );

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isLoading ? const LinearProgressIndicator() : null,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //         top: 6.v,
                  //         bottom: 9.v,
                  //       ),
                  //       child: SizedBox(
                  //         width: 79.h,
                  //         child: const Divider(),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(left: 12.h),
                  //       child: Text(
                  //         "Or sign up with",
                  //         style: CustomTextStyles.bodyMediumBluegray200,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //         top: 6.v,
                  //         bottom: 9.v,
                  //       ),
                  //       child: SizedBox(
                  //         width: 91.h,
                  //         child: Divider(
                  //           indent: 12.h,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 19.v),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     _buildGoogle(context),
                  //     _buildFacebook(context),
                  //   ],
                  // ),
                  SizedBox(height: 41.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: CustomTextStyles.bodyMediumff495057,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.signInScreen),
                        child: Text(
                          "Sign in",
                          style: CustomTextStyles.titleSmallff52b788,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5.v),
                ],
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
          fit: BoxFit.fill,
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
                  height: 50.v,
                  width: 146.h,
                  margin: EdgeInsets.only(bottom: 25.v),
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            ImageConstant.imgSettings,
            height: 45,
            width: 45,
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
  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        validator: validateEmail,
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
        validator: validatePassword,
        controller: passwordController,
        hintText: "********",
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 18.v, 24.h, 18.v),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _hidePassWord = !_hidePassWord;
              });
            },
            child:Icon(
              _hidePassWord ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: appTheme.gray600,
            ),
          )
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 56.v,
        ),
        obscureText: _hidePassWord,
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
        validator: (value) => validateConfirmPassword(
          value,
          passwordController.text,
        ),
        controller: confirmPasswordController,
        hintText: "********",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 18.v, 24.h, 18.v),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _hideConfirmPassword = !_hideConfirmPassword;
              });
            },
            child:Icon(
              _hideConfirmPassword ? Icons.visibility_off : Icons.visibility,
              size: 20,
              color: appTheme.gray600,
            ),
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 56.v,
        ),
        obscureText: _hideConfirmPassword,
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
            setState(() {
              agreeWithTerm = value;
            });
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        _signUp();
      },
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
      onPressed: onGoogleSignIn,
      width: 127.h,
      text: "Google",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 16.h),
        child: SvgPicture.asset(
          ImageConstant.imgGoogle,
          width: 20,
          height: 20,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillOnPrimaryContainer,
      buttonTextStyle: CustomTextStyles.titleSmallBlack900,
    );
  }

  /// Section Widget
  Widget _buildFacebook(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onFacebookSignIn,
      width: 136.h,
      text: "Facebook",
      margin: EdgeInsets.only(left: 24.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 16.h),
        child: SvgPicture.asset(
          ImageConstant.imgFacebook,
          width: 20,
          height: 20,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillIndigo,
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimaryContainer,
    );
  }
}
