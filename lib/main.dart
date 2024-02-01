import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartresource/presentation/email_verification_screen/email_verification_screen.dart';
import 'package:smartresource/presentation/home_screen/home_screen.dart';
import 'package:smartresource/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:smartresource/presentation/welcome_screen/welcome_screen.dart';

import 'core/app_export.dart';
import 'firebase_options.dart';

bool isFirstLaunch = true;

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.remove('isFirstLaunch');
  isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  await prefs.setBool('isFirstLaunch', false);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'smart_resources',
          debugShowCheckedModeBanner: false,
          routes: AppRoutes.routes,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (FirebaseAuth.instance.currentUser!.emailVerified) {
                    return HomeScreen();
                  } else {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    return EmailVerificationScreen(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.homeScreen),
                      email: FirebaseAuth.instance.currentUser!.email!,
                    );
                  }
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }

              if (isFirstLaunch) {
                return const WelcomeScreen();
              }
              return const SignInScreen();
            },
          ),
        );
      },
    );
  }
}
