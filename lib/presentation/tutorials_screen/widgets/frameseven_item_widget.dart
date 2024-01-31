import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class FramesevenItemWidget extends StatelessWidget {
  const FramesevenItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 7.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "Bottle",
        style: TextStyle(
          color: theme.colorScheme.onPrimaryContainer,
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.blueGray50,
      selectedColor: appTheme.blueGray50,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          15.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
