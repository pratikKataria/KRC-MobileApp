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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8kveR-dqiLcoumREH3ZPqa04jdLOMOCQ',
    appId: '1:610941004705:android:9a101336fb7b07299739e0',
    messagingSenderId: '610941004705',
    projectId: 'krc-homes',
    storageBucket: 'krc-homes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAk96F7Rzri3XFP9dVBuSKABBiC5XbFP-k',
    appId: '1:610941004705:ios:1bfb992eca8415069739e0',
    messagingSenderId: '610941004705',
    projectId: 'krc-homes',
    storageBucket: 'krc-homes.appspot.com',
    androidClientId: '610941004705-mtj0h3153cat4mjd8cgtlcb8ek1qkatt.apps.googleusercontent.com',
    iosClientId: '610941004705-sa6j3l6acdl11h2bv2vbo8bqc2skkbur.apps.googleusercontent.com',
    iosBundleId: 'com.stetig.krc',
  );
}
