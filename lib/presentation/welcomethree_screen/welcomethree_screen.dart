import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomethreeScreen extends StatelessWidget {
  const WelcomethreeScreen({Key? key})
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
              SizedBox(height: 76.v),
              CustomImageView(
                imagePath: ImageConstant.imgBrandLoyaltyRafiki,
                height: 300.v,
                width: 373.h,
              ),
              SizedBox(height: 52.v),
              Container(
                width: 352.h,
                margin: EdgeInsets.only(
                  left: 10.h,
                  right: 19.h,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Connect",
                        style: theme.textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: ", ",
                        style: CustomTextStyles.headlineSmallff000000,
                      ),
                      TextSpan(
                        text: "trade",
                        style: theme.textTheme.headlineSmall,
                      ),
                      TextSpan(
                        text: ", and ",
                        style: CustomTextStyles.headlineSmallff000000,
                      ),
                      TextSpan(
                        text: "exchange eco-friendly ideas",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 43.v),
              Container(
                width: 333.h,
                margin: EdgeInsets.only(
                  left: 19.h,
                  right: 28.h,
                ),
                child: Text(
                  "Join a community of like-minded individuals dedicated to sustainability, where you can share ideas, learn new techniques, and collaborate on projects that make a difference.",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLargeRobotoBlack900,
                ),
              ),
              SizedBox(height: 46.v),
              _buildFrameSeventeen(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameSeventeen(BuildContext context) {
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
