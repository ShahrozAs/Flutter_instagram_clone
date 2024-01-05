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
    apiKey: 'AIzaSyBwjXy5PJUDnJJEdwhzBOcaXPFNh0AN65w',
    appId: '1:321093815508:android:e727f6b58cdcb67c613f41',
    messagingSenderId: '321093815508',
    projectId: 'instagram-clone-b9eab',
    databaseURL: 'https://instagram-clone-b9eab-default-rtdb.firebaseio.com',
    storageBucket: 'instagram-clone-b9eab.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAaOOc1V0kV1-atpTiYpzQeEJU1jUEEteM',
    appId: '1:321093815508:ios:21d185e521539112613f41',
    messagingSenderId: '321093815508',
    projectId: 'instagram-clone-b9eab',
    databaseURL: 'https://instagram-clone-b9eab-default-rtdb.firebaseio.com',
    storageBucket: 'instagram-clone-b9eab.appspot.com',
    iosBundleId: 'com.example.instagramClone',
  );
}
