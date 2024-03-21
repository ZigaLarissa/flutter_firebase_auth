import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore = FirebaseFirestore.instance; //
FirebaseAuth auth =
    FirebaseAuth.instance; //recommend declaring a reference outside the methods

Future<String> getUserEmail() async {
  final user = auth.currentUser;
  final userData = await firestore.collection('users').doc(user!.uid).get();
  return userData['email'];
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder<String>(
            future: getUserEmail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return Text('Welcome ${snapshot.data}');
            },
          ),
        ),
      ),
    );
  }
}
