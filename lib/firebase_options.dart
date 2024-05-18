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
    apiKey: 'AIzaSyARrao5zFOFvuzw1Kz63fAJLCPN-X_nhLc',
    appId: '1:231515510914:web:e03bb4484cd92000e37c9b',
    messagingSenderId: '231515510914',
    projectId: 'govbo-e682a',
    authDomain: 'govbo-e682a.firebaseapp.com',
    storageBucket: 'govbo-e682a.appspot.com',
    measurementId: 'G-LM11DZXC68',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTDb6dFjtLNoBCR1ijCNI3cTPY3-F1r3w',
    appId: '1:231515510914:android:149884dda74f7485e37c9b',
    messagingSenderId: '231515510914',
    projectId: 'govbo-e682a',
    storageBucket: 'govbo-e682a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYqQtrJKkjWT6F4AI_aLYQz1-ZX4UlDXk',
    appId: '1:231515510914:ios:08cd051e16b09bd2e37c9b',
    messagingSenderId: '231515510914',
    projectId: 'govbo-e682a',
    storageBucket: 'govbo-e682a.appspot.com',
    iosBundleId: 'com.example.govbot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYqQtrJKkjWT6F4AI_aLYQz1-ZX4UlDXk',
    appId: '1:231515510914:ios:08cd051e16b09bd2e37c9b',
    messagingSenderId: '231515510914',
    projectId: 'govbo-e682a',
    storageBucket: 'govbo-e682a.appspot.com',
    iosBundleId: 'com.example.govbot',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyARrao5zFOFvuzw1Kz63fAJLCPN-X_nhLc',
    appId: '1:231515510914:web:17562cc0764aedfce37c9b',
    messagingSenderId: '231515510914',
    projectId: 'govbo-e682a',
    authDomain: 'govbo-e682a.firebaseapp.com',
    storageBucket: 'govbo-e682a.appspot.com',
    measurementId: 'G-WXZ35S8QY7',
  );
}