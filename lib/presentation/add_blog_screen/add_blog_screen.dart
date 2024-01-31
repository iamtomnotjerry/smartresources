import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class AddBlogScreen extends StatelessWidget {
  AddBlogScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController blogTitleController = TextEditingController();

  TextEditingController thumbnailImageURLController = TextEditingController();

  TextEditingController blogContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 24.h,
            top: 69.v,
            right: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.h),
                child: Text(
                  "Add New Blog",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 35.v),
              _buildInputWithLabel(context),
              SizedBox(height: 23.v),
              Text(
                "Thumbnail",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 7.v),
              _buildInput(context),
              SizedBox(height: 9.v),
              Text(
                "Or import from URL",
                style: CustomTextStyles.bodyMediumGray600,
              ),
              SizedBox(height: 6.v),
              CustomTextFormField(
                controller: thumbnailImageURLController,
                hintText: "Thumbnail image URL",
              ),
              SizedBox(height: 23.v),
              Text(
                "Content",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 7.v),
              CustomTextFormField(
                controller: blogContentController,
                hintText: "Blog content...",
                textInputAction: TextInputAction.done,
                maxLines: 7,
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
          controller: blogTitleController,
          hintText: "Blog title",
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildInput(BuildContext context) {
    return DottedBorder(
      color: theme.colorScheme.onError,
      padding: EdgeInsets.only(
        left: 1.h,
        top: 1.v,
        right: 1.h,
        bottom: 1.v,
      ),
      strokeWidth: 1.h,
      radius: const Radius.circular(12),
      borderType: BorderType.RRect,
      dashPattern: const [
        8,
        8,
      ],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 119.h,
          vertical: 38.v,
        ),
        decoration: AppDecoration.outlineOnError.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgCalendarOnerror,
              height: 48.adaptSize,
              width: 48.adaptSize,
            ),
            SizedBox(height: 11.v),
            Text(
              "Choose file to upload",
              style: CustomTextStyles.bodyMediumBluegray200,
            ),
          ],
        ),
      ),
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
        text: "Publish",
      ),
    );
  }
}
