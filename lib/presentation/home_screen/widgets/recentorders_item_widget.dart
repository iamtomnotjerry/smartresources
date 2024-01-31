import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class RecentordersItemWidget extends StatelessWidget {
  const RecentordersItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnsplashGgtwjdt6dci3,
            height: 134.v,
            width: 170.h,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          SizedBox(height: 9.v),
          SizedBox(
            width: 170.h,
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: theme.textTheme.titleSmall!.copyWith(
                height: 1.14,
              ),
            ),
          ),
          SizedBox(height: 2.v),
          Text(
            "24,000đ",
            style: theme.textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
