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
    apiKey: 'AIzaSyA8QijHyBxipae-8JifBKK5KUObgsXRXoI',
    appId: '1:6320355917:web:734ac8a421e4bbfa99fa04',
    messagingSenderId: '6320355917',
    projectId: 'lh-imoveis',
    authDomain: 'lh-imoveis.firebaseapp.com',
    storageBucket: 'lh-imoveis.firebasestorage.app',
    measurementId: 'G-274LENGB3P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBon0DfDVIWnSTBUoZbgkamhFJIFPsaxtc',
    appId: '1:6320355917:android:4ad521ceeb9314e499fa04',
    messagingSenderId: '6320355917',
    projectId: 'lh-imoveis',
    storageBucket: 'lh-imoveis.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwo7TvMQ8xqcAuX1rr7BLoqRiNOFoI7jA',
    appId: '1:6320355917:ios:84de073d977d32f199fa04',
    messagingSenderId: '6320355917',
    projectId: 'lh-imoveis',
    storageBucket: 'lh-imoveis.firebasestorage.app',
    iosBundleId: 'com.example.appFront',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwo7TvMQ8xqcAuX1rr7BLoqRiNOFoI7jA',
    appId: '1:6320355917:ios:84de073d977d32f199fa04',
    messagingSenderId: '6320355917',
    projectId: 'lh-imoveis',
    storageBucket: 'lh-imoveis.firebasestorage.app',
    iosBundleId: 'com.example.appFront',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA8QijHyBxipae-8JifBKK5KUObgsXRXoI',
    appId: '1:6320355917:web:205b490b5c1313f899fa04',
    messagingSenderId: '6320355917',
    projectId: 'lh-imoveis',
    authDomain: 'lh-imoveis.firebaseapp.com',
    storageBucket: 'lh-imoveis.firebasestorage.app',
    measurementId: 'G-VJ5MSGL8QG',
  );
}