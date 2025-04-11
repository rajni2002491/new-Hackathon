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
    apiKey: 'AIzaSyBDhLcFJyqneAEZTiOMe8T2uNH1ZL3C038',
    appId: '1:772247576952:web:d4f6ed8e54e91f92fe688d',
    messagingSenderId: '772247576952',
    projectId: 'mentore-auth',
    authDomain: 'mentore-auth.firebaseapp.com',
    storageBucket: 'mentore-auth.firebasestorage.app',
    measurementId: 'G-KBKFR58B53',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCe6arf5jiKYqaPU3WKClumHuRfs2cSvko',
    appId: '1:772247576952:android:c1a49a585d1a3c96fe688d',
    messagingSenderId: '772247576952',
    projectId: 'mentore-auth',
    storageBucket: 'mentore-auth.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrGNlHl8hIBF1Ima83C2R-Wh8zQ8Ram9o',
    appId: '1:772247576952:ios:e202d0448acae002fe688d',
    messagingSenderId: '772247576952',
    projectId: 'mentore-auth',
    storageBucket: 'mentore-auth.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrGNlHl8hIBF1Ima83C2R-Wh8zQ8Ram9o',
    appId: '1:772247576952:ios:e202d0448acae002fe688d',
    messagingSenderId: '772247576952',
    projectId: 'mentore-auth',
    storageBucket: 'mentore-auth.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBDhLcFJyqneAEZTiOMe8T2uNH1ZL3C038',
    appId: '1:772247576952:web:1bb3d2aee85ce667fe688d',
    messagingSenderId: '772247576952',
    projectId: 'mentore-auth',
    authDomain: 'mentore-auth.firebaseapp.com',
    storageBucket: 'mentore-auth.firebasestorage.app',
    measurementId: 'G-8P45QESYF8',
  );
}
