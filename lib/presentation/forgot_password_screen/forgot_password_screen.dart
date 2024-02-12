import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isEmailSent = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void onSend() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);

      setState(() {
        isLoading = false;
        isEmailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isLoading ? const LinearProgressIndicator() : null,
      appBar: AppBar(
          title: Text(
        'Forgot Password',
        style: TextStyle(
          color: theme.colorScheme.primary,
        ),
      )),
      body: isEmailSent
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 24,
                top: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 64,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Reset password email sent',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: appTheme.blueGray700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'You’ll get messages soon on your e-mail address. Please check your email and follow the instructions to reset your password.',
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    height: 56,
                    text: 'Back to login',
                    buttonStyle: CustomButtonStyles.fillPrimary,
                    buttonTextStyle:
                        CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
                  ),
                ],
              ),
            )
          : SizedBox(
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
                      left: 23.h,
                      top: 24.v,
                      right: 23.h,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 23.v),
                        SizedBox(
                          width: 266.h,
                          child: Text(
                            "You’ll get messages soon on your e-mail address.",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        SizedBox(height: 59.v),
                        _buildInputWithLabel(context),
                        SizedBox(height: 45.v),
                        CustomElevatedButton(
                          onPressed: () => onSend(),
                          height: 56.v,
                          text: "Send",
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle: CustomTextStyles
                              .titleMediumOnPrimaryContainerSemiBold,
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
  Widget _buildInputWithLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          CustomTextFormField(
            validator: validateEmail,
            controller: emailController,
            hintText: "example@gmail.com",
            autofocus: true,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
