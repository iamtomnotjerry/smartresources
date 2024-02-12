import 'package:flutter/material.dart';
import 'package:smartresource/presentation/blogs_screen/blogs_screen.dart';
import 'package:smartresource/presentation/home_screen/home_screen.dart';
import 'package:smartresource/presentation/profile_screen/profile_screen.dart';
import 'package:smartresource/presentation/shop_screen/shop_screen.dart';
import 'package:smartresource/widgets/custom_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override 
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const BlogsScreen(),
    const ShopScreen(),
    const ProfileScreen(),
  ];


  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
        onChanged: (BottomBarEnum type) {
      },
    );
  }
}