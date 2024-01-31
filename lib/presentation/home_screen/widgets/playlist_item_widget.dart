import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class PlaylistItemWidget extends StatelessWidget {
  const PlaylistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.h,
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgUnsplashGgtwjdt6dci,
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
        ],
      ),
    );
  }
}
