import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class UserprofilesectionItemWidget extends StatelessWidget {
  const UserprofilesectionItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.v),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnsplashN7wmtrqv5am,
            height: 127.adaptSize,
            width: 127.adaptSize,
            radius: BorderRadius.circular(
              8.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 33.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 224.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "By: ",
                              style: CustomTextStyles.bodySmallff495057,
                            ),
                            TextSpan(
                              text: "Anonymous",
                              style: CustomTextStyles.bodySmallff6c757d,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "21/1/2024",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7.v),
                Text(
                  "Đèn trang trí làm bằng chai nhựa",
                  style: CustomTextStyles.titleSmallSemiBold,
                ),
                SizedBox(height: 9.v),
                Text(
                  "24,000đ",
                  style: CustomTextStyles.titleMediumPrimary,
                ),
                SizedBox(height: 8.v),
                Container(
                  height: 18.v,
                  width: 32.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 3.v,
                  ),
                  decoration: AppDecoration.fillRed.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder8,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgThumbsUpOnprimarycontainer,
                    height: 12.adaptSize,
                    width: 12.adaptSize,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
