import 'package:firebase_auth/firebase_auth.dart';
import 'package:punkte_zaehler/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebaseApp() async {
  if (Firebase.apps.isEmpty) {
    print('Inizialzed FirebaseApp');
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('After inizialized');
  } else {
    Firebase.app(); // if already initialized, use that one
  }
}
