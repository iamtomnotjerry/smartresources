import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 18.v),
              CustomImageView(
                imagePath: ImageConstant.imgSettings,
                height: 68.adaptSize,
                width: 68.adaptSize,
              ),
              SizedBox(height: 61.v),
              Text(
                "Smart Resource",
                style: CustomTextStyles.headlineLargeBaloo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
