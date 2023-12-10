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
    apiKey: 'AIzaSyDSrQx9TQ5I0vzGG1Q6OM6i0PJxyionbYI',
    appId: '1:410955422159:web:c720f80e130562965e1aba',
    messagingSenderId: '410955422159',
    projectId: 'students-384bf',
    authDomain: 'students-384bf.firebaseapp.com',
    storageBucket: 'students-384bf.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFosLAqp2UoyD6e_aMS3plHScnC0m11R0',
    appId: '1:410955422159:android:c669b0a575d4394c5e1aba',
    messagingSenderId: '410955422159',
    projectId: 'students-384bf',
    storageBucket: 'students-384bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA27sbw4m8s3sHj2Ob-Fy9kXiEtlyisDmI',
    appId: '1:410955422159:ios:b8b0437322b0129a5e1aba',
    messagingSenderId: '410955422159',
    projectId: 'students-384bf',
    storageBucket: 'students-384bf.appspot.com',
    iosBundleId: 'com.nesdzo.studentApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA27sbw4m8s3sHj2Ob-Fy9kXiEtlyisDmI',
    appId: '1:410955422159:ios:f0ffce4ff3f00e285e1aba',
    messagingSenderId: '410955422159',
    projectId: 'students-384bf',
    storageBucket: 'students-384bf.appspot.com',
    iosBundleId: 'com.nesdzo.studentApp.RunnerTests',
  );
}