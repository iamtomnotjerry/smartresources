import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/onboarding_screen/onboarding_screen.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 22.h,
          vertical: 68.v,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 14.h,
                    top: 12.v,
                    bottom: 5.v,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Smart",
                          style: CustomTextStyles.headlineSmallBaloo,
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: "Resources",
                          style: CustomTextStyles.headlineSmallBalooff6c757d,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.v),
            _buildOurPlanet(context),
            SizedBox(height: 24.v),
            Container(
              width: 364.h,
              margin: EdgeInsets.only(
                left: 10.h,
                right: 11.h,
              ),
              child: Text(
                "Cras vestibulum eros in lectus posuere cursus semper sit amet tortor.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.bodyLargeIBMPlexMonoBlack900ExtraLight,
              ),
            ),
            SizedBox(height: 13.v),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 3.h),
                child: Text(
                  "- Anonymous -",
                  style: CustomTextStyles.bodyLargeIBMPlexMonoBlack900,
                ),
              ),
            ),
            const Spacer(),
            CustomElevatedButton(
              onPressed: () {
                // Navigate to welcomeoneScreen when the button is pressed
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnboardingScreen()));
              },
              height: 56.v,
              text: "Get Started",
              buttonStyle: CustomButtonStyles.fillPrimary,
              buttonTextStyle:
                  CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildOurPlanet(BuildContext context) {
    return SizedBox(
      height: 435.v,
      width: 386.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage1,
            height: 386.adaptSize,
            width: 386.adaptSize,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 45.h,
                right: 47.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Our ",
                          style:
                              CustomTextStyles.headlineSmallFigmaHandff000000,
                        ),
                        TextSpan(
                          text: "planet,",
                          style: CustomTextStyles.headlineSmallFigmaHand,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 4.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Our ",
                            style:
                                CustomTextStyles.headlineSmallFigmaHandff000000,
                          ),
                          TextSpan(
                            text: "responsibility",
                            style: CustomTextStyles.headlineSmallFigmaHand,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
