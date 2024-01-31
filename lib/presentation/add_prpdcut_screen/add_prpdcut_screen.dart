import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class AddPrpdcutScreen extends StatelessWidget {
  AddPrpdcutScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameInputController = TextEditingController();

  TextEditingController priceInputController = TextEditingController();

  TextEditingController productDescriptionInputController =
      TextEditingController();

  TextEditingController thumbnailImageURLInputController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(height: 67.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 64.h),
                        child: Text(
                          "Add New Product",
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 37.v),
                    _buildInputWithLabel(context),
                    SizedBox(height: 23.v),
                    _buildInputWithLabel1(context),
                    SizedBox(height: 24.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Description",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.v),
                    _buildProductDescriptionInput(context),
                    SizedBox(height: 8.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Images",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.v),
                    _buildImageInput(context),
                    SizedBox(height: 9.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text(
                          "Or import from URL",
                          style: CustomTextStyles.bodyMediumGray600,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.v),
                    _buildFrame(context),
                    SizedBox(height: 22.v),
                    _buildBottomNavigation(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNameInput(BuildContext context) {
    return CustomTextFormField(
      controller: nameInputController,
      hintText: "Product name",
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          _buildNameInput(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPriceInput(BuildContext context) {
    return CustomTextFormField(
      controller: priceInputController,
      hintText: "Product price",
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Price",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 7.v),
          _buildPriceInput(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildProductDescriptionInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: CustomTextFormField(
        controller: productDescriptionInputController,
        hintText: "Product description",
        maxLines: 7,
      ),
    );
  }

  /// Section Widget
  Widget _buildImageInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: DottedBorder(
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
      ),
    );
  }

  /// Section Widget
  Widget _buildThumbnailImageURLInput(BuildContext context) {
    return Expanded(
      child: CustomTextFormField(
        controller: thumbnailImageURLInputController,
        hintText: "Thumbnail image URL",
        textInputAction: TextInputAction.done,
      ),
    );
  }

  /// Section Widget
  Widget _buildLoadButton(BuildContext context) {
    return CustomElevatedButton(
      height: 44.v,
      width: 72.h,
      text: "Load",
      margin: EdgeInsets.only(
        left: 8.h,
        top: 6.v,
        bottom: 6.v,
      ),
      buttonStyle: CustomButtonStyles.fillPrimaryTL12,
      buttonTextStyle: CustomTextStyles.titleSmallOnPrimaryContainer_1,
    );
  }

  /// Section Widget
  Widget _buildFrame(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildThumbnailImageURLInput(context),
          _buildLoadButton(context),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPublishButton(BuildContext context) {
    return const CustomElevatedButton(
      text: "Publish",
    );
  }

  /// Section Widget
  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.h),
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16.v),
          _buildPublishButton(context),
        ],
      ),
    );
  }
}
