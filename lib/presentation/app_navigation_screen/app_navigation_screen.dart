import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        body: SizedBox(
          width: 375.h,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Blog details",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Splash",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Welcome",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "WelcomeOne",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "WelcomeTwo",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "WelcomeThree",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign up",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign in",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Complete profile",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Forgot password",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Email verification",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Tutorials",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Tutorial details",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add blog One",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Blogs",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add blog",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Shop",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Product details Two",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Cart",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add Prpdcut",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Profile",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Your Profile",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Change Password",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: const Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: const Color(0XFF888888),
          ),
        ],
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
