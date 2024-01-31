import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/widgets/custom_drop_down.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_icon_button.dart';
import 'package:smartresource/widgets/custom_phone_number.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({Key? key})
      : super(
          key: key,
        );

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('1');

  TextEditingController phoneNumberController = TextEditingController();

  List<String> dropdownItemList = [
    "Item One",
    "Item Two",
    "Item Three",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 23.h,
            top: 70.v,
            right: 23.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 42.h),
                child: Text(
                  "Complete Your Profile",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 24.v),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 288.h,
                  margin: EdgeInsets.only(
                    left: 50.h,
                    right: 45.h,
                  ),
                  child: Text(
                    "Don’t worry, only you can see your personal data. No one else will be bale to see it.",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 43.v),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 128.adaptSize,
                  width: 128.adaptSize,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup10,
                        height: 128.adaptSize,
                        width: 128.adaptSize,
                        alignment: Alignment.center,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 6.h),
                        child: CustomIconButton(
                          height: 32.adaptSize,
                          width: 32.adaptSize,
                          padding: EdgeInsets.all(6.h),
                          alignment: Alignment.bottomRight,
                          child: CustomImageView(
                            imagePath: ImageConstant.imgGroup11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 42.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Phone number",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 7.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: CustomPhoneNumber(
                  country: selectedCountry,
                  controller: phoneNumberController,
                  onTap: (Country value) {
                    selectedCountry = value;
                  },
                ),
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Gender",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 7.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: CustomDropDown(
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
              ),
              SizedBox(height: 15.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Date of birth",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 7.v),
              _buildDateOfBirthSection(context),
              SizedBox(height: 48.v),
              CustomElevatedButton(
                height: 56.v,
                text: "Complete Profile",
                margin: EdgeInsets.only(left: 2.h),
                buttonStyle: CustomButtonStyles.fillPrimary,
                buttonTextStyle:
                    CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDateOfBirthSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.h),
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
}
