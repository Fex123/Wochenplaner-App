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
    apiKey: 'AIzaSyAlcg4DbISQC43KP44_SP0pwxeBS7IwA90',
    appId: '1:515751962614:web:2f9dfba23cf6f11c99c9d7',
    messagingSenderId: '515751962614',
    projectId: 'wochenplaner-app',
    authDomain: 'wochenplaner-app.firebaseapp.com',
    storageBucket: 'wochenplaner-app.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBp63AEBKf-lePtMqRyvcS2WtYFjAPkD3c',
    appId: '1:515751962614:android:aa4e50669d1f05d899c9d7',
    messagingSenderId: '515751962614',
    projectId: 'wochenplaner-app',
    storageBucket: 'wochenplaner-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAABMForg-gnLdiMyp3zsokXlF0h1yBv4M',
    appId: '1:515751962614:ios:6ad498e1e0de0f9f99c9d7',
    messagingSenderId: '515751962614',
    projectId: 'wochenplaner-app',
    storageBucket: 'wochenplaner-app.firebasestorage.app',
    iosBundleId: 'com.example.wochenplanerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAABMForg-gnLdiMyp3zsokXlF0h1yBv4M',
    appId: '1:515751962614:ios:6ad498e1e0de0f9f99c9d7',
    messagingSenderId: '515751962614',
    projectId: 'wochenplaner-app',
    storageBucket: 'wochenplaner-app.firebasestorage.app',
    iosBundleId: 'com.example.wochenplanerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAlcg4DbISQC43KP44_SP0pwxeBS7IwA90',
    appId: '1:515751962614:web:45d4d1e845bfb34099c9d7',
    messagingSenderId: '515751962614',
    projectId: 'wochenplaner-app',
    authDomain: 'wochenplaner-app.firebaseapp.com',
    storageBucket: 'wochenplaner-app.firebasestorage.app',
  );
}
