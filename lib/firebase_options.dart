// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDvpIBLY-Vc6vGzhnKxhHfPWBdyenR1FmE',
    appId: '1:1003283949583:web:99d5ebefa420ebc7835b7a',
    messagingSenderId: '1003283949583',
    projectId: 'smart-resources-d4f2e',
    authDomain: 'smart-resources-d4f2e.firebaseapp.com',
    storageBucket: 'smart-resources-d4f2e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTCd4yh-D5Q5hHEUoCPg8P-RZ-7Gmyp3U',
    appId: '1:1003283949583:android:35d75f8d8c89e398835b7a',
    messagingSenderId: '1003283949583',
    projectId: 'smart-resources-d4f2e',
    storageBucket: 'smart-resources-d4f2e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD2lSG25U9YYGVSthLgqkXmbAq3qvjeQo',
    appId: '1:1003283949583:ios:e4d04af20b6f8c6e835b7a',
    messagingSenderId: '1003283949583',
    projectId: 'smart-resources-d4f2e',
    storageBucket: 'smart-resources-d4f2e.appspot.com',
    androidClientId: '1003283949583-34qhg5dj6qj3grtplsl1kln0r5lr5513.apps.googleusercontent.com',
    iosClientId: '1003283949583-rpd8mh3di6sca0h50j04hqpsqglb2rih.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartresource',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD2lSG25U9YYGVSthLgqkXmbAq3qvjeQo',
    appId: '1:1003283949583:ios:7362ff0c022674f1835b7a',
    messagingSenderId: '1003283949583',
    projectId: 'smart-resources-d4f2e',
    storageBucket: 'smart-resources-d4f2e.appspot.com',
    androidClientId: '1003283949583-34qhg5dj6qj3grtplsl1kln0r5lr5513.apps.googleusercontent.com',
    iosClientId: '1003283949583-dp9krdnif0ssstl1jgc9gs3mtss0kkva.apps.googleusercontent.com',
    iosBundleId: 'com.example.smartresource.RunnerTests',
  );
}
