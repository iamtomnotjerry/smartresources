import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class AddBlogOneScreen extends StatelessWidget {
  AddBlogOneScreen({super.key});

  TextEditingController titlevalueController = TextEditingController();

  TextEditingController videovalueController = TextEditingController();

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 24.h,
            top: 66.v,
            right: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.h),
                child: Text(
                  "Add Tutorial",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 38.v),
              _buildInputWithLabel(context),
              SizedBox(height: 23.v),
              Text(
                "Video",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 7.v),
              CustomTextFormField(
                controller: videovalueController,
                hintText: "Embed video link from Youtube",
              ),
              SizedBox(height: 24.v),
              Text(
                "Description",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 6.v),
              CustomTextFormField(
                controller: inputController,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 7.v),
        CustomTextFormField(
          controller: titlevalueController,
          hintText: "Tutorial title",
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 32.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: const CustomElevatedButton(
        text: "Upload",
      ),
    );
  }
}
