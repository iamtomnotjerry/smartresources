import '../product_details_two_screen/widgets/thirtyfour_item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/app_bar/appbar_leading_iconbutton.dart';
import 'package:smartresource/widgets/app_bar/custom_app_bar.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsTwoScreen extends StatelessWidget {
  ProductDetailsTwoScreen({Key? key})
      : super(
          key: key,
        );

  int sliderIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 3.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettings(context),
              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.only(left: 11.h),
                child: Text(
                  "Đèn trang trí làm bằng chai nhựa",
                  style: CustomTextStyles.titleLargeBluegray7000123,
                ),
              ),
              SizedBox(height: 34.v),
              Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Text(
                  "Description",
                  style: CustomTextStyles.titleMedium18,
                ),
              ),
              SizedBox(height: 12.v),
              Container(
                width: 382.h,
                margin: EdgeInsets.symmetric(horizontal: 9.h),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dapibus suscipit augue sit amet suscipit.\nSed sollicitudin mauris et eros imperdiet ullamcorper.\nAliquam risus metus, maximus eu mauris vel, gravida vulputate velit.\nNullam in mi dictum, dictum libero sed, auctor nunc. Sed ut tincidunt augue, eget convallis sapien. Ut fringilla volutpat finibus.",
                  maxLines: 11,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyles.bodyLargeBluegray70001.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 58.v),
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  margin: EdgeInsets.only(right: 9.h),
                  color: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyle.circleBorder22,
                  ),
                  child: Container(
                    height: 44.adaptSize,
                    width: 44.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 10.v,
                    ),
                    decoration: AppDecoration.outlineBlack900.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder22,
                    ),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgCartOnprimarycontainer,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 10.adaptSize,
                            padding: EdgeInsets.symmetric(horizontal: 3.h),
                            decoration: AppDecoration.fillGreen.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder5,
                            ),
                            child: Text(
                              "1",
                              style: CustomTextStyles.labelSmallGray600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingIconbutton(
        margin: EdgeInsets.fromLTRB(24.h, 10.v, 370.h, 10.v),
      ),
    );
  }

  /// Section Widget
  Widget _buildSettings(BuildContext context) {
    return Container(
      height: 259.v,
      width: 397.h,
      margin: EdgeInsets.only(left: 3.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 11.v,
              child: AnimatedSmoothIndicator(
                activeIndex: 0,
                count: 5,
                effect: ScrollingDotsEffect(
                  spacing: 4.64,
                  activeDotColor: theme.colorScheme.primary,
                  dotColor: appTheme.gray30001,
                  activeDotScale: 1.375,
                  dotHeight: 8.v,
                  dotWidth: 9.h,
                ),
              ),
            ),
          ),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 260.v,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (
                index,
                reason,
              ) {
                sliderIndex = index;
              },
            ),
            itemCount: 6,
            itemBuilder: (context, index, realIndex) {
              return const ThirtyfourItemWidget();
            },
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 36.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price",
                  style: CustomTextStyles.titleSmallBluegray200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    "24,000đ",
                    style: CustomTextStyles.titleMediumPrimary,
                  ),
                ),
              ],
            ),
          ),
          CustomElevatedButton(
            height: 44.v,
            width: 175.h,
            text: "Add to cart",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgGrid,
                height: 24.adaptSize,
                width: 24.adaptSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
