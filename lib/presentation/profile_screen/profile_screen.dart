import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyAuthProvider>(context).user;

    return Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1,
                        right: 1,
                        bottom: -48,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: user.avatar.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 64,
                                          backgroundImage:
                                              NetworkImage(user.avatar),
                                        )
                                      : CircleAvatar(
                                          radius: 64,
                                          backgroundImage: AssetImage(
                                            ImageConstant.avatarPlaceholder,
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        theme.colorScheme.primary,
                                      ),
                                    ),
                                    constraints: const BoxConstraints(
                                      maxHeight: 48,
                                      maxWidth: 48,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 96),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        const MenuItem(
                          title: 'My Profile',
                          icon: Icons.person_outline_rounded,
                        ),
                        const MenuItem(
                          title: 'Purchase History',
                          icon: Icons.assignment_outlined,
                        ),
                        const MenuItem(
                          title: 'My Addresses',
                          icon: Icons.location_on_outlined,
                        ),
                        const MenuItem(
                          title: 'Payment Methods',
                          icon: Icons.credit_card_outlined,
                        ),
                        const MenuItem(
                          title: 'Account Settings',
                          icon: Icons.settings_outlined,
                        ),
                        const MenuItem(
                          title: 'Help & Support',
                          icon: Icons.help_outline,
                        ),
                        MenuItem(
                          title: 'Sign Out',
                          icon: Icons.logout,
                          onPressed: () {
                            AuthService().signOut(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
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
