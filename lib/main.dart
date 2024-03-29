
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartresource/navigation_menu.dart';
import 'package:smartresource/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:smartresource/presentation/welcome_screen/welcome_screen.dart';
import 'package:smartresource/providers/auth_provider.dart';
import 'package:smartresource/providers/blogs_provider.dart';
import 'package:smartresource/providers/network_manager.dart';
import 'package:smartresource/providers/products_provider.dart';
import 'package:smartresource/providers/tutorials_provider.dart';

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

  if (kIsWeb) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "427968716234838",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.remove('isFirstLaunch');
  isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  await prefs.setBool('isFirstLaunch', false);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAuthProvider()),
        ChangeNotifierProvider(create: (context) => TutorialsProvider()),
        ChangeNotifierProvider(create: (context) => BlogsProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => NetworkManager()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            theme: theme,
            title: 'smart_resources',
            debugShowCheckedModeBanner: false,
            routes: AppRoutes.routes,
            home: Builder(builder: (context) {
              final isConnect = Provider.of<NetworkManager>(context).isConnect;
              if (!isConnect) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Oops! No internet connection.',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Retry',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return const NavigationMenu();
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
              );
            }),
          );
        },
      ),
    );
  }
}
