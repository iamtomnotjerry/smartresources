import 'package:flutter/material.dart';
import 'package:smartresource/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using a Future.delayed to wait for 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
          context, AppRoutes.welcomeScreen); // Use the route directly
    });

    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 18.v),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0), // Adjust padding as needed
              child:
                  Icon(Icons.eco, size: 72.0, color: theme.colorScheme.primary),
            ),
            SizedBox(height: 61.v),
            Text(
              "Smart Resource",
              style: CustomTextStyles.headlineLargeBaloo,
            ),
          ],
        ),
      ),
    );
  }
}
