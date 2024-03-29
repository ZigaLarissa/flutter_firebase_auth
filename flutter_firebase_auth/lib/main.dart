import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAYjjjtuH8WwnnVKDH6-IhbIhPFFLg0T2s',
      appId: '1:290122446372:android:8cc13dfde88766b0d18ab1',
      messagingSenderId: '290122446372',
      projectId: 'flutter-firebase-auth-a5753',
    ),
  );

  // Initialize the GoogleAuthProvider
  //await GoogleAuthProvider.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
