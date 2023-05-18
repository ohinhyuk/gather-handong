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
    apiKey: 'AIzaSyAyU3G9jAlbE0MVvX6hKv06CjdYOYz97qk',
    appId: '1:430558202405:web:8785e2e4c6c4b1770ecdcc',
    messagingSenderId: '430558202405',
    projectId: 'moapp-final-project-154b3',
    authDomain: 'moapp-final-project-154b3.firebaseapp.com',
    storageBucket: 'moapp-final-project-154b3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF7c0PjUm3yTEs2QbThMev0lHz9nvq2jc',
    appId: '1:430558202405:android:102b22c5fa32c3da0ecdcc',
    messagingSenderId: '430558202405',
    projectId: 'moapp-final-project-154b3',
    storageBucket: 'moapp-final-project-154b3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCu8FagWdpXhlGMDA1a_19aZX2GZvYXY-s',
    appId: '1:430558202405:ios:a92ad5850ddef0e30ecdcc',
    messagingSenderId: '430558202405',
    projectId: 'moapp-final-project-154b3',
    storageBucket: 'moapp-final-project-154b3.appspot.com',
    iosClientId: '430558202405-pbjh5ljkhv2ls9863kjprelup0ldbve6.apps.googleusercontent.com',
    iosBundleId: 'com.example.gatherHandong',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCu8FagWdpXhlGMDA1a_19aZX2GZvYXY-s',
    appId: '1:430558202405:ios:a92ad5850ddef0e30ecdcc',
    messagingSenderId: '430558202405',
    projectId: 'moapp-final-project-154b3',
    storageBucket: 'moapp-final-project-154b3.appspot.com',
    iosClientId: '430558202405-pbjh5ljkhv2ls9863kjprelup0ldbve6.apps.googleusercontent.com',
    iosBundleId: 'com.example.gatherHandong',
  );
}
