import 'package:flutter/material.dart';
import 'package:smartresource/navigation_menu.dart';
import 'package:smartresource/presentation/add_blog_one_screen/add_blog_one_screen.dart';
import 'package:smartresource/presentation/add_blog_screen/add_blog_screen.dart';
import 'package:smartresource/presentation/add_prpdcut_screen/add_prpdcut_screen.dart';
import 'package:smartresource/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:smartresource/presentation/blog_details_screen/blog_details_screen.dart';
import 'package:smartresource/presentation/blogs_screen/blogs_screen.dart';
import 'package:smartresource/presentation/cart_screen/cart_screen.dart';
import 'package:smartresource/presentation/change_password_screen/change_password_screen.dart';
import 'package:smartresource/presentation/forgot_password_screen/forgot_password_screen.dart';
import 'package:smartresource/presentation/home_screen/home_screen.dart';
import 'package:smartresource/presentation/main_screen/main_screen.dart';
import 'package:smartresource/presentation/product_details_two_screen/product_details_two_screen.dart';
import 'package:smartresource/presentation/profile_screen/profile_screen.dart';
import 'package:smartresource/presentation/settings_screen/settings_screen.dart';
import 'package:smartresource/presentation/shop_screen/shop_screen.dart';
import 'package:smartresource/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:smartresource/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:smartresource/presentation/splash_screen/splash_screen.dart';
import 'package:smartresource/presentation/tutorial_details_screen/tutorial_details_screen.dart';
import 'package:smartresource/presentation/tutorials_screen/tutorials_screen.dart';
import 'package:smartresource/presentation/welcome_screen/welcome_screen.dart';
import 'package:smartresource/presentation/welcomeone_screen/welcomeone_screen.dart';
import 'package:smartresource/presentation/welcomethree_screen/welcomethree_screen.dart';
import 'package:smartresource/presentation/welcometwo_screen/welcometwo_screen.dart';
import 'package:smartresource/presentation/your_profile_screen/your_profile_screen.dart';

class AppRoutes {
  static const String mainScreen = '/main_screen';

  static const String blogDetailsScreen = '/blog_details_screen';

  static const String splashScreen = '/splash_screen';

  static const String welcomeScreen = '/welcome_screen';

  static const String welcomeoneScreen = '/welcomeone_screen';

  static const String welcometwoScreen = '/welcometwo_screen';

  static const String welcomethreeScreen = '/welcomethree_screen';

  static const String signUpScreen = '/sign_up_screen';

  static const String signInScreen = '/sign_in_screen';

  static const String completeProfileScreen = '/complete_profile_screen';

  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String emailVerificationScreen = '/email_verification_screen';

  static const String homeScreen = '/home_screen';

  static const String tutorialsScreen = '/tutorials_screen';

  static const String tutorialDetailsScreen = '/tutorial_details_screen';

  static const String addBlogOneScreen = '/add_blog_one_screen';

  static const String blogsScreen = '/blogs_screen';

  static const String addBlogScreen = '/add_blog_screen';

  static const String shopScreen = '/shop_screen';

  static const String productDetailsTwoScreen = '/product_details_two_screen';

  static const String cartScreen = '/cart_screen';

  static const String addPrpdcutScreen = '/add_prpdcut_screen';

  static const String profileScreen = '/profile_screen';

  static const String yourProfileScreen = '/your_profile_screen';

  static const String settingsScreen = '/settings_screen';

  static const String changePasswordScreen = '/change_password_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    mainScreen: (context) => const MainScreen(),
    blogDetailsScreen: (context) => const BlogDetailsScreen(),
    splashScreen: (context) => const SplashScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    welcomeoneScreen: (context) => const WelcomeoneScreen(),
    welcometwoScreen: (context) => const WelcometwoScreen(),
    welcomethreeScreen: (context) => const WelcomethreeScreen(),
    signUpScreen: (context) => SignUpScreen(),
    signInScreen: (context) => SignInScreen(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    homeScreen: (context) => NavigationMenu(),
    tutorialsScreen: (context) => TutorialsScreen(),
    tutorialDetailsScreen: (context) => const TutorialDetailsScreen(),
    addBlogOneScreen: (context) => AddBlogOneScreen(),
    blogsScreen: (context) => BlogsScreen(),
    addBlogScreen: (context) => AddBlogScreen(),
    shopScreen: (context) => ShopScreen(),
    productDetailsTwoScreen: (context) => ProductDetailsTwoScreen(),
    cartScreen: (context) => const CartScreen(),
    addPrpdcutScreen: (context) => AddPrpdcutScreen(),
    profileScreen: (context) => ProfileScreen(),
    yourProfileScreen: (context) => MyProfileScreen(),
    settingsScreen: (context) => AccountSettingsScreen(),
    changePasswordScreen: (context) => ChangePasswordScreen(),
    appNavigationScreen: (context) => const AppNavigationScreen()
  };
}
