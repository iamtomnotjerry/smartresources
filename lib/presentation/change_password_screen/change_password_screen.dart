import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/core/utils/validation_functions.dart';
import 'package:smartresource/widgets/custom_elevated_button.dart';
import 'package:smartresource/widgets/custom_text_form_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formkey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final user = FirebaseAuth.instance.currentUser!;
      final credential = EmailAuthProvider.credential(
          email: user.email!, password: currentPasswordController.text);

      await user.reauthenticateWithCredential(credential).then((_) {
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Password Change'),
            content:
                const Text('Are you sure you want to change your password?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });

                    await user.updatePassword(newPasswordController.text);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed successfully.'),
                      ),
                    );

                    Navigator.pop(context);

                    confirmNewPasswordController.clear();
                    newPasswordController.clear();
                    currentPasswordController.clear();

                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Something went wrong. Please try again.'),
                      ),
                    );
                  }
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }).catchError((_) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Current password is incorrect.'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      ),
      body: Column(
        children: [
          isLoading ? const LinearProgressIndicator() : Container(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Password',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        validator: (v) => validatePassword(v, strong: false),
                        controller: currentPasswordController,
                        hintText: '********',
                        obscureText: true,
                        suffix: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: appTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Password',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: newPasswordController,
                        validator: validatePassword,
                        hintText: '********',
                        obscureText: true,
                        suffix: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: appTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Confirm New Password',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomTextFormField(
                        controller: confirmNewPasswordController,
                        validator: (v) => validateConfirmPassword(
                          v,
                          newPasswordController.text,
                        ),
                        hintText: '********',
                        obscureText: true,
                        suffix: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: appTheme.gray600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 56),
                  CustomElevatedButton(
                    text: 'Change Password',
                    onPressed: onSubmit,
                    height: 56,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
