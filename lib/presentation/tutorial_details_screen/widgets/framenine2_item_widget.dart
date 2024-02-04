import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class Framenine2ItemWidget extends StatelessWidget {
  final String materialItem;
  const Framenine2ItemWidget({
    super.key,
    required this.materialItem,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: Colors.transparent,
      ),
      child: RawChip(
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        label: Text(
          materialItem,
          style: TextStyle(
            color: appTheme.blueGray700,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: false,
        backgroundColor: appTheme.gray100,
        selectedColor: Colors.transparent,
        onSelected: (value) {},
        side: const BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
