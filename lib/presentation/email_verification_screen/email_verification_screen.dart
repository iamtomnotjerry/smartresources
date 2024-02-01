import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({
    Key? key,
    required this.email,
     this.onPressed,
  }) : super(
          key: key,
        );

  final String email;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Email Verification',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 24.h,
          top: 68.v,
          right: 24.h,
        ),
        child: Column(
          children: [
            SizedBox(
              width: 260.h,
              child: Text(
                "Check your mailbox to verify your email address.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 34.v),
            _buildFrameFortyThree(context),
            SizedBox(height: 25.v),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Didn’t receive any email? ",
                    style: CustomTextStyles.bodyLargeff6c757d,
                  ),
                  TextSpan(
                    text: "Resend",
                    style: CustomTextStyles.titleMediumff52b788,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 32.v),
            CustomElevatedButton(
              text: 'Continue',
              height: 48,
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameFortyThree(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 32,
      ),
      decoration: AppDecoration.fillBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Text(
        email,
        style: CustomTextStyles.titleMedium18,
      ),
    );
  }
}
