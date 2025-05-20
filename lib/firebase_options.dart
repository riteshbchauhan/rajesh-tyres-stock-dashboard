import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
    apiKey: 'AIzaSyAvN4-37V_iZU4qp84fGqwo1FjnJpfj8GA',
    appId: '1:479231856377:web:cd7b945a32944c68249c28',
    messagingSenderId: '479231856377',
    projectId: 'rajesh-tyres-stock-dashboard',
    authDomain: 'rajesh-tyres-stock-dashboard.firebaseapp.com',
    storageBucket: 'rajesh-tyres-stock-dashboard.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvN4-37V_iZU4qp84fGqwo1FjnJpfj8GA',
    appId: '1:479231856377:android:cd7b945a32944c68249c28',
    messagingSenderId: '479231856377',
    projectId: 'rajesh-tyres-stock-dashboard',
    storageBucket: 'rajesh-tyres-stock-dashboard.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvN4-37V_iZU4qp84fGqwo1FjnJpfj8GA',
    appId: '1:479231856377:ios:cd7b945a32944c68249c28',
    messagingSenderId: '479231856377',
    projectId: 'rajesh-tyres-stock-dashboard',
    storageBucket: 'rajesh-tyres-stock-dashboard.firebasestorage.app',
    iosClientId: '479231856377-ios-client-id',
    iosBundleId: 'com.rajeshtyres.inventory',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvN4-37V_iZU4qp84fGqwo1FjnJpfj8GA',
    appId: '1:479231856377:macos:cd7b945a32944c68249c28',
    messagingSenderId: '479231856377',
    projectId: 'rajesh-tyres-stock-dashboard',
    storageBucket: 'rajesh-tyres-stock-dashboard.firebasestorage.app',
    iosClientId: '479231856377-macos-client-id',
    iosBundleId: 'com.rajeshtyres.inventory',
  );
}
