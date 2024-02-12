import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  void onDeleteAccount(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .delete();
              FirebaseAuth.instance.currentUser!.delete();
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.signInScreen,
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
                        'password'
                    ? MenuItem(
                        title: 'Change Password',
                        icon: Icons.lock_reset_outlined,
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.changePasswordScreen,
                        ),
                      )
                    : Container(),
                MenuItem(
                  title: 'Delete Account',
                  icon: Icons.delete_outlined,
                  onPressed: () => onDeleteAccount(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
  });

  final String title;
  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 2, top: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: appTheme.gray100),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onPressed,
        horizontalTitleGap: 24,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 28,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
