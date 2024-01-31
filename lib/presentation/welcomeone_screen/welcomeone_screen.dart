import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeoneScreen extends StatelessWidget {
  const WelcomeoneScreen({Key? key})
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
            top: 62.v,
            right: 24.h,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgBookmark,
                    height: 48.adaptSize,
                    width: 48.adaptSize,
                  ),
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
              SizedBox(height: 2.v),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Skip",
                  style: CustomTextStyles.bodyLargePrimary,
                ),
              ),
              SizedBox(height: 50.v),
              Column(
                children: [
                  Container(
                    decoration: AppDecoration.fillOnPrimaryContainer,
                    child: Column(
                      children: [
                        SizedBox(height: 9.v),
                        _buildUpcycleRafikiSection(context),
                      ],
                    ),
                  ),
                  SizedBox(height: 49.v),
                  _buildFrameSeventeenSection(context),
                ],
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUpcycleRafikiSection(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 1.h),
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgUpcycleRafiki,
                    height: 347.v,
                    width: 381.h,
                  ),
                  SizedBox(height: 37.v),
                  Container(
                    width: 266.h,
                    margin: EdgeInsets.only(
                      left: 56.h,
                      right: 58.h,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Dive into ",
                            style: CustomTextStyles.headlineSmallff000000,
                          ),
                          TextSpan(
                            text: "recycling",
                            style: theme.textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: " and ",
                            style: CustomTextStyles.headlineSmallff000000,
                          ),
                          TextSpan(
                            text: "upcycling creativity",
                            style: theme.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 43.v),
                  Container(
                    width: 349.h,
                    margin: EdgeInsets.only(
                      left: 12.h,
                      right: 19.h,
                    ),
                    child: Text(
                      "Get creative with recycling and upcycling, turning old items into new treasures while reducing waste and protecting the environment.",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyLargeRobotoBlack900,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 382.v,
                bottom: 7.v,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 24.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Turn ",
                            style: CustomTextStyles.headlineSmallff000000,
                          ),
                          TextSpan(
                            text: "ideas",
                            style: theme.textTheme.headlineSmall,
                          ),
                          TextSpan(
                            text: " into ",
                            style: CustomTextStyles.headlineSmallff000000,
                          ),
                          TextSpan(
                            text: "reality with recycled materials",
                            style: theme.textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 44.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 15.h,
                      child: Text(
                        "Follow our easy-to-follow DIY tutorials, transforming everyday materials into unique, handmade creations that showcase your creativity",
                        maxLines: null,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.bodyLargeRobotoBlack900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameSeventeenSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(
          height: 48.adaptSize,
          width: 48.adaptSize,
          padding: EdgeInsets.all(12.h),
          decoration: IconButtonStyleHelper.fillBlueGray,
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowLeft,
          ),
        ),
        Container(
          height: 16.v,
          margin: EdgeInsets.symmetric(vertical: 16.v),
          child: AnimatedSmoothIndicator(
            activeIndex: 0,
            count: 3,
            effect: ScrollingDotsEffect(
              spacing: 12,
              activeDotColor: theme.colorScheme.primary,
              dotColor: appTheme.blueGray100,
              dotHeight: 16.v,
              dotWidth: 16.h,
            ),
          ),
        ),
        CustomIconButton(
          height: 48.adaptSize,
          width: 48.adaptSize,
          padding: EdgeInsets.all(12.h),
          decoration: IconButtonStyleHelper.fillPrimary,
          child: CustomImageView(
            imagePath: ImageConstant.imgArrowRight,
          ),
        ),
      ],
    );
  }
}
