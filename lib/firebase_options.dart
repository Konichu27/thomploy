// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCZU8Tz5c_SsVzsZ7yrstt6fv531GQ4l4E',
    appId: '1:679262721077:web:2f272fed00984ffb1f8d7c',
    messagingSenderId: '679262721077',
    projectId: 'thomploy-dd289',
    authDomain: 'thomploy-dd289.firebaseapp.com',
    storageBucket: 'thomploy-dd289.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVyqENqYbBHFRkb9cuYkQ3xfkfWJLlJy4',
    appId: '1:679262721077:android:b4f536965a7dd2ab1f8d7c',
    messagingSenderId: '679262721077',
    projectId: 'thomploy-dd289',
    storageBucket: 'thomploy-dd289.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0oJxmJF6pA_Kwojy0wAYM78dz_5JoSxI',
    appId: '1:679262721077:ios:610728d48818cb641f8d7c',
    messagingSenderId: '679262721077',
    projectId: 'thomploy-dd289',
    storageBucket: 'thomploy-dd289.firebasestorage.app',
    iosBundleId: 'com.example.thomploy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0oJxmJF6pA_Kwojy0wAYM78dz_5JoSxI',
    appId: '1:679262721077:ios:610728d48818cb641f8d7c',
    messagingSenderId: '679262721077',
    projectId: 'thomploy-dd289',
    storageBucket: 'thomploy-dd289.firebasestorage.app',
    iosBundleId: 'com.example.thomploy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCZU8Tz5c_SsVzsZ7yrstt6fv531GQ4l4E',
    appId: '1:679262721077:web:a1dae7f1f6ecb8dd1f8d7c',
    messagingSenderId: '679262721077',
    projectId: 'thomploy-dd289',
    authDomain: 'thomploy-dd289.firebaseapp.com',
    storageBucket: 'thomploy-dd289.firebasestorage.app',
  );
}