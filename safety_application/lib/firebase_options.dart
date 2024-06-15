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
    apiKey: 'AIzaSyAatc1nKkGHIeiDY326udW9SXbPuaQ_Qs8',
    appId: '1:353784544371:web:fae62624b8a4785d5b3e06',
    messagingSenderId: '353784544371',
    projectId: 'safety-application-db3d1',
    authDomain: 'safety-application-db3d1.firebaseapp.com',
    storageBucket: 'safety-application-db3d1.appspot.com',
    measurementId: 'G-61EE0JWQG5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvmvApxdevLKe_K6VoCB_t7qguKhOBiF4',
    appId: '1:353784544371:android:cbd424dabf267f0d5b3e06',
    messagingSenderId: '353784544371',
    projectId: 'safety-application-db3d1',
    storageBucket: 'safety-application-db3d1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkLQxC_zcgYvJQxcGsInhhs2kTW01ltWM',
    appId: '1:353784544371:ios:b4a6328a66bd545f5b3e06',
    messagingSenderId: '353784544371',
    projectId: 'safety-application-db3d1',
    storageBucket: 'safety-application-db3d1.appspot.com',
    iosClientId: '353784544371-mtmt0k46hkalb7julpg2ub95brflib6b.apps.googleusercontent.com',
    iosBundleId: 'com.example.safetyApplication',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkLQxC_zcgYvJQxcGsInhhs2kTW01ltWM',
    appId: '1:353784544371:ios:b4a6328a66bd545f5b3e06',
    messagingSenderId: '353784544371',
    projectId: 'safety-application-db3d1',
    storageBucket: 'safety-application-db3d1.appspot.com',
    iosClientId: '353784544371-mtmt0k46hkalb7julpg2ub95brflib6b.apps.googleusercontent.com',
    iosBundleId: 'com.example.safetyApplication',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAatc1nKkGHIeiDY326udW9SXbPuaQ_Qs8',
    appId: '1:353784544371:web:18326d8adb890aea5b3e06',
    messagingSenderId: '353784544371',
    projectId: 'safety-application-db3d1',
    authDomain: 'safety-application-db3d1.firebaseapp.com',
    storageBucket: 'safety-application-db3d1.appspot.com',
    measurementId: 'G-BWVXLTFTZ2',
  );

}