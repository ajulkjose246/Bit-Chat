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
    apiKey: 'AIzaSyAgUycOrANDLTz87gbSVLbBg1xttJKJ5NU',
    appId: '1:92016110783:web:50966d1e4332981e956a0a',
    messagingSenderId: '92016110783',
    projectId: 'bit-chat--v1',
    authDomain: 'bit-chat--v1.firebaseapp.com',
    storageBucket: 'bit-chat--v1.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8TaFR3oPiNYFifwPSyjKXvWaBPhGeEkg',
    appId: '1:92016110783:android:49a11d8f253439ce956a0a',
    messagingSenderId: '92016110783',
    projectId: 'bit-chat--v1',
    storageBucket: 'bit-chat--v1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBYkctAJrWy76Zv30Ci4BSAryM6PcLCy0',
    appId: '1:92016110783:ios:c79885dc2c6d902c956a0a',
    messagingSenderId: '92016110783',
    projectId: 'bit-chat--v1',
    storageBucket: 'bit-chat--v1.appspot.com',
    iosBundleId: 'com.example.bitchat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBYkctAJrWy76Zv30Ci4BSAryM6PcLCy0',
    appId: '1:92016110783:ios:567f8b120759d68d956a0a',
    messagingSenderId: '92016110783',
    projectId: 'bit-chat--v1',
    storageBucket: 'bit-chat--v1.appspot.com',
    iosBundleId: 'com.example.bitchat.RunnerTests',
  );
}
