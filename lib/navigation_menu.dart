import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartresource/core/app_export.dart';
import 'package:smartresource/presentation/blogs_screen/blogs_screen.dart';
import 'package:smartresource/presentation/home_screen/home_screen.dart';
import 'package:smartresource/presentation/profile_screen/profile_screen.dart';
import 'package:smartresource/presentation/shop_screen/shop_screen.dart';
import 'package:smartresource/presentation/tutorials_screen/tutorials_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';

class NavigationMenu extends StatefulWidget {
  NavigationMenu({super.key, this.initialPage = 0});

  final int initialPage;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late PageController pageController;

  late int page;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialPage);
    page = widget.initialPage;
    Provider.of<MyAuthProvider>(context, listen: false).refreshUser();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: appTheme.gray600.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: CupertinoTabBar(
              backgroundColor: Colors.transparent,
              border: Border.all(
                color: Colors.transparent,
              ),
              inactiveColor: appTheme.gray600,
              currentIndex: page,
              onTap: (page) => pageController.jumpToPage(page),
              items: const [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home_rounded),
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.smart_display_rounded),
                  icon: Icon(Icons.smart_display_outlined),
                  label: 'Tutorials',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.feed_rounded),
                  icon: Icon(Icons.feed_outlined),
                  label: 'Blogs',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.storefront_rounded),
                  icon: Icon(Icons.storefront_outlined),
                  label: 'Shop',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.account_circle_rounded),
                  icon: Icon(Icons.account_circle_outlined),
                  label: 'Profile',
                ),
              ]),
        ),
      ),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            page = value;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          TutorialsScreen(),
          BlogsScreen(),
          ShopScreen(),
          const ProfileScreen(),
        ],
      ),
    );
  }
}
