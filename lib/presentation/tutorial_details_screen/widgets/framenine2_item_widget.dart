import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class Framenine2ItemWidget extends StatelessWidget {
  final String materialItem;
  Framenine2ItemWidget({super.key, required this.materialItem});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: RawChip(
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          materialItem,
          style: TextStyle(
            color: appTheme.gray600,
            fontSize: 12.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: false,
        backgroundColor: Colors.transparent,
        selectedColor: Colors.transparent,
        onSelected: (value) {},
      ),
    );
  }
}
