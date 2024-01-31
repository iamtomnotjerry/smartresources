import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_drop_down.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_phone_number.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class YourProfileScreen extends StatelessWidget {
  YourProfileScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController inputWithLabelNameController = TextEditingController();

  TextEditingController inputWithLabelEmailController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('1');

  TextEditingController phoneNumberController = TextEditingController();

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

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
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 24.h,
                  vertical: 57.v,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 9.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40.h),
                        child: Text(
                          "Profile",
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 21.v),
                    SizedBox(
                      height: 142.adaptSize,
                      width: 142.adaptSize,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomImageView(
                            imagePath:
                                ImageConstant.imgUnsplashZhvm3xiohoe142x142,
                            height: 142.adaptSize,
                            width: 142.adaptSize,
                            radius: BorderRadius.circular(
                              71.h,
                            ),
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 9.h,
                              bottom: 3.v,
                            ),
                            child: CustomIconButton(
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              padding: EdgeInsets.all(7.h),
                              decoration: IconButtonStyleHelper
                                  .outlineOnPrimaryContainer,
                              alignment: Alignment.bottomRight,
                              child: CustomImageView(
                                imagePath:
                                    ImageConstant.imgEditOnprimarycontainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.v),
                    _buildInputWithLabel(context),
                    SizedBox(height: 23.v),
                    _buildInputWithLabel1(context),
                    SizedBox(height: 23.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone number",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildPhoneNumber(context),
                    SizedBox(height: 23.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Gender",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 7.v),
                    CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 16.v, 24.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowdown,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      hintText: "Select",
                      items: dropdownItemList,
                      onChanged: (value) {},
                    ),
                    SizedBox(height: 23.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Date of birth",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    SizedBox(height: 7.v),
                    _buildInputDateOfBirth(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildInputWithLabelName(BuildContext context) {
    return CustomTextFormField(
      controller: inputWithLabelNameController,
      hintText: "Esther Hosward",
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 7.v),
        _buildInputWithLabelName(context),
      ],
    );
  }

  /// Section Widget
  Widget _buildInputWithLabelEmail(BuildContext context) {
    return CustomTextFormField(
      controller: inputWithLabelEmailController,
      hintText: "eshterhosward@gmail.com",
      hintStyle: CustomTextStyles.bodyLargeGray600,
      textInputType: TextInputType.emailAddress,
    );
  }

  /// Section Widget
  Widget _buildInputWithLabel1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: theme.textTheme.titleMedium,
        ),
        SizedBox(height: 7.v),
        _buildInputWithLabelEmail(context),
      ],
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
      country: selectedCountry,
      controller: phoneNumberController,
      onTap: (Country value) {
        selectedCountry = value;
      },
    );
  }

  /// Section Widget
  Widget _buildInputDateOfBirth(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.fillBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 2.v,
              bottom: 1.v,
            ),
            child: Text(
              "DD/MM/YYYY",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgCalendar,
            height: 24.adaptSize,
            width: 24.adaptSize,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildButtonUpdateProfile(BuildContext context) {
    return const CustomElevatedButton(
      text: "Update Profile",
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
      decoration: BoxDecoration(
        borderRadius: BorderRadiusStyle.customBorderTL24,
      ),
      child: _buildButtonUpdateProfile(context),
    );
  }
}
