import 'framenine1_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class TablelampItemWidget extends StatelessWidget {
  const TablelampItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        color: theme.colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Container(
          height: 307.v,
          width: 382.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 15.v,
          ),
          decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgUnsplash9okgevjitkk,
                height: 200.v,
                width: 350.h,
                radius: BorderRadius.circular(
                  10.h,
                ),
                alignment: Alignment.topCenter,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 47.v),
                  child: Text(
                    "How to make a table lamp with plastic bottles",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(right: 14.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomIconButton(
                        height: 38.v,
                        width: 37.h,
                        padding: EdgeInsets.all(3.h),
                        alignment: Alignment.center,
                        child: CustomImageView(
                          imagePath: ImageConstant.imgPlayCircle,
                        ),
                      ),
                      SizedBox(height: 59.v),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 33.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 1.v,
                          ),
                          decoration: AppDecoration.fillBlack,
                          child: Text(
                            "4:13",
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ),
                      SizedBox(height: 43.v),
                      Wrap(
                        runSpacing: 4.89.v,
                        spacing: 4.89.h,
                        children: List<Widget>.generate(
                            5, (index) => const Framenine1ItemWidget()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
