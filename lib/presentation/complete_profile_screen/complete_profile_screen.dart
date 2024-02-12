import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/pick_image.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/services/auth_service.dart';
import 'package:smartresource/widgets/custom_drop_down.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? gender;
  DateTime? dateOfBirth;
  Uint8List? avatar;

  bool isLoading = false;

  List<String> dropdownItemList = [
    "Male",
    "Female",
    "Other",
  ];

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      if (gender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your gender'),
          ),
        );
        return;
      }

      if (dateOfBirth == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your date of birth'),
          ),
        );
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });

        await AuthService().updateProfile(
          uid: widget.uid,
          name: nameController.text,
          dateOfBirth: dateOfBirth!.toString(),
          phoneNumber: phoneNumberController.text,
          gender: gender!.toLowerCase(),
          avatar: avatar,
        );

        Navigator.of(context).pushReplacementNamed(
          AppRoutes.signInScreen,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Please try again.'),
          ),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _selectAvatar() async {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Add a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.camera);
                  if (file != null) {
                    setState(() {
                      avatar = file;
                    });
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery);
                  if (file != null) {
                    setState(() {
                      avatar = file;
                    });
                  }
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Complete Your Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLoading ? const LinearProgressIndicator() : Container(),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 23.h,
                top: 32.v,
                right: 23.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "Don’t worry, only you can see your personal data. No one else will be bale to see it.",
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
                            avatar == null
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(
                                      ImageConstant.avatarPlaceholder,
                                    ),
                                    radius: 64,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image(
                                      width: 128,
                                      height: 128,
                                      image: MemoryImage(avatar!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () => _selectAvatar(),
                                color: Colors.white,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    theme.colorScheme.primary,
                                  ),
                                ),
                                alignment: Alignment.center,
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 42.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.h),
                        child: Text(
                          "Name",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: CustomTextFormField(
                        validator: validateName,
                        controller: nameController,
                        hintText: "John Doe",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 15.v),
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
                      child: InternationalPhoneNumberInput(
                        validator: (value) => value == null || value.isEmpty
                            ? "Please enter your phone number"
                            : null,
                        textFieldController: phoneNumberController,
                        onInputChanged: (value) {},
                        selectorConfig: const SelectorConfig(
                          useEmoji: true,
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        initialValue: PhoneNumber(
                          phoneNumber: "",
                          isoCode: 'VN',
                        ),
                        textStyle: CustomTextStyles.titleMediumPrimaryContainer,
                        inputDecoration: InputDecoration(
                          fillColor: appTheme.blueGray50.withOpacity(0.8),
                          filled: true,
                          hintText: 'XXX XXX XXXX',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.h),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(18.h),
                          hintStyle: theme.textTheme.bodyLarge,
                        ),
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
                        hintStyle: CustomTextStyles.titleMediumPrimaryContainer,
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
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
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
                      onPressed: () => onSubmit(),
                      height: 56.v,
                      text: "Complete Profile",
                      margin: EdgeInsets.only(left: 2.h),
                      buttonStyle: CustomButtonStyles.fillPrimary,
                      buttonTextStyle: CustomTextStyles
                          .titleMediumOnPrimaryContainerSemiBold,
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
      });
    }
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
              dateOfBirth != null
                  ? '${dateOfBirth!.day}/${dateOfBirth!.month}/${dateOfBirth!.year}'
                  : "DD/MM/YYYY",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Icon(
              Icons.calendar_month,
              size: 24,
              color: appTheme.blueGray700.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}
