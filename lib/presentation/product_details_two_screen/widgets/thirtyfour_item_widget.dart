import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class ThirtyfourItemWidget extends StatelessWidget {
  final String image;
  
  const ThirtyfourItemWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CustomImageView(
        imagePath: image,
        height: 235.v,
        width: 397.h,
        radius: BorderRadius.circular(
          16.h,
        ),
        margin: EdgeInsets.only(bottom: 24.v),
      ),
    );
  }
}
