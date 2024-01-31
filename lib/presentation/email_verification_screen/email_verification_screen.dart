import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 24.h,
            top: 68.v,
            right: 24.h,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 41.h),
                  child: Text(
                    "Email Verification",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 25.v),
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
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameFortyThree(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 1.h),
      padding: EdgeInsets.symmetric(
        horizontal: 101.h,
        vertical: 34.v,
      ),
      decoration: AppDecoration.fillBluegray50.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.v),
          Text(
            "example@gmail.com",
            style: CustomTextStyles.titleMedium18,
          ),
        ],
      ),
    );
  }
}
