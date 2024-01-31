import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class UserprofilelistItemWidget extends StatelessWidget {
  const UserprofilelistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9.v),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140.adaptSize,
            width: 140.adaptSize,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgUnsplashN7wmtrqv5am,
                  height: 140.adaptSize,
                  width: 140.adaptSize,
                  radius: BorderRadius.circular(
                    8.h,
                  ),
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 7.v,
                    right: 7.h,
                  ),
                  child: CustomIconButton(
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    padding: EdgeInsets.all(4.h),
                    decoration: IconButtonStyleHelper.fillGray,
                    alignment: Alignment.topRight,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgPlus,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 29.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 182.h,
                  child: Text(
                    "Đèn trang trí làm bằng chai nhựa",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmallSemiBold,
                  ),
                ),
                SizedBox(height: 4.v),
                SizedBox(
                  width: 210.h,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut congue scelerisque sodales. Praesent non arcu erat. Aliquam erat volutpat. Praesent facilisis felis sed convallis venenatis. Mauris sit amet quam ultrices ipsum viverra dignissim. Donec risus lorem, euismod quis quam id, sagittis varius neque. Nunc eu dapibus nisi, non efficitur nibh. Donec et leo vitae eros semper dictum. Nulla interdum et tortor quis eleifend. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut ut volutpat justo. Phasellus non ipsum vitae nunc varius interdum. Morbi malesuada sit amet velit a tristique. In hac habitasse platea dictumst.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.bodySmallGray600_1,
                  ),
                ),
                SizedBox(height: 4.v),
                SizedBox(
                  width: 212.h,
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
                SizedBox(height: 9.v),
                Text(
                  "24,000đ",
                  style: theme.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
