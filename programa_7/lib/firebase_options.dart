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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCoxMaJVUndsozY2nQRg1T2XMHRFvdvCic',
    appId: '1:933785842062:web:ed69c39ef513b448c734df',
    messagingSenderId: '933785842062',
    projectId: 'fir-424cf',
    authDomain: 'fir-424cf.firebaseapp.com',
    storageBucket: 'fir-424cf.appspot.com',
    measurementId: 'G-KR2FNTFBGH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC2sajqYtKPUSZC9x3Kyx_skRi4thEqWA',
    appId: '1:933785842062:android:1ead022fc5051707c734df',
    messagingSenderId: '933785842062',
    projectId: 'fir-424cf',
    storageBucket: 'fir-424cf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD_10N-A3knt3Oaz8J9XJNlwnHJb7N1MM',
    appId: '1:933785842062:ios:78be4d46169e32dbc734df',
    messagingSenderId: '933785842062',
    projectId: 'fir-424cf',
    storageBucket: 'fir-424cf.appspot.com',
    iosClientId: '933785842062-mn587pc02g9tbq49g6uqc2taflnqsgq9.apps.googleusercontent.com',
    iosBundleId: 'com.example.programa7',
  );
}
