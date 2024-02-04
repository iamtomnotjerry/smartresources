import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/pick_image.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/services/auth_service.dart';
import 'package:smartresource/widgets/custom_drop_down.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<MyProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<MyProfileScreen> {
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
  void initState() {
    super.initState();
    final user = Provider.of<MyAuthProvider>(context, listen: false).user;
    if (user != null) {
      setState(
        () {
          nameController.text = user.name;
          phoneNumberController.text = user.phoneNumber;
          gender = user.gender[0].toUpperCase() + user.gender.substring(1);
          dateOfBirth = DateTime.parse(user.dateOfBirth);
        },
      );
    }
  }

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
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: nameController.text,
          dateOfBirth: dateOfBirth!.toString(),
          phoneNumber: phoneNumberController.text,
          gender: gender!.toLowerCase(),
          avatar: avatar,
          avatarChanged: avatar != null,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Update profile successfully!'),
          ),
        );

        Provider.of<MyAuthProvider>(context, listen: false).refreshUser();
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
    final user = Provider.of<MyAuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My profile",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, -4),
                blurRadius: 8,
              ),
            ],
            borderRadius: BorderRadius.circular(32),
          ),
          child: CustomElevatedButton(
            onPressed: () => onSubmit(),
            height: 56.v,
            text: "Complete Profile",
            margin: EdgeInsets.only(left: 2.h),
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle:
                CustomTextStyles.titleMediumOnPrimaryContainerSemiBold,
          ),
        ),
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
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
                            child: SizedBox(
                              height: 128.adaptSize,
                              width: 128.adaptSize,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  user.avatar.isNotEmpty && avatar == null
                                      ? CircleAvatar(
                                          radius: 64,
                                          backgroundImage:
                                              NetworkImage(user.avatar),
                                        )
                                      : avatar != null
                                          ? CircleAvatar(
                                              radius: 64,
                                              backgroundImage:
                                                  MemoryImage(avatar!),
                                            )
                                          : CircleAvatar(
                                              radius: 64,
                                              backgroundImage: AssetImage(
                                                ImageConstant.avatarPlaceholder,
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
                                        backgroundColor:
                                            MaterialStatePropertyAll(
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
                              validator: (value) =>
                                  value == null || value.isEmpty
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
                              textStyle:
                                  CustomTextStyles.titleMediumPrimaryContainer,
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
                              hintStyle:
                                  CustomTextStyles.titleMediumPrimaryContainer,
                              icon: Container(
                                margin:
                                    EdgeInsets.fromLTRB(30.h, 16.v, 24.h, 16.v),
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
                              value: gender,
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
              style: CustomTextStyles.titleMediumPrimaryContainer,
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
