import '../cart_screen/widgets/userprofilesection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key})
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
            top: 61.v,
            right: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.h),
                child: Text(
                  "Cart",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 32.v),
              _buildUserProfileSection(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationSection(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileSection(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 1.h),
        decoration: AppDecoration.outlineBlack,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 18.v,
            );
          },
          itemCount: 2,
          itemBuilder: (context, index) {
            return const UserprofilesectionItemWidget();
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 34.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Container(
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.customBorderTL24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style: CustomTextStyles.titleSmallBluegray200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    "112,000đ",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            CustomElevatedButton(
              height: 44.v,
              width: 175.h,
              text: "Buy Now",
            ),
          ],
        ),
      ),
    );
  }
}
