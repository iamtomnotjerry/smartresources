import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

// ignore: must_be_immutable
class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.text,
  }) : super(
          key: key,
        );

  final String text;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        text,
        style: TextStyle(
          color: appTheme.black900,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.blueGray50,
      selectedColor: appTheme.blueGray50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      side: const BorderSide(width: 0, color: Colors.transparent),
      onSelected: (value) {},
    );
  }
}
