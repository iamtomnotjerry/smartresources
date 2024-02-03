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
                        bottom: -80,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                                const SizedBox(height: 8),
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
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
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 24,
                    ),
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
                          MenuItem(
                            title: 'My Profile',
                            icon: Icons.person_outline_rounded,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.yourProfileScreen,
                            ),
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
                          MenuItem(
                            title: 'Account Settings',
                            icon: Icons.settings_outlined,
                            onPressed: () => Navigator.pushNamed(
                              context,
                              AppRoutes.settingsScreen,
                            ),
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
                  ),
                  const SizedBox(height: 32),
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
