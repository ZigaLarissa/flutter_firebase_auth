// ignore_for_file: avoid_print
// import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  String email = '';
  String password = '';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '290122446372-t1g60eh8e2p1olln8brpt4uts48a8o4i.apps.googleusercontent.com',
  );
  late GoogleSignInAccount _userObj;

  Future<void> onValidate() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    try {
      if (_isLogin) {
        final existingUser = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(existingUser);
      } else {
        final newUserCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(newUserCredential);
        // After successfully creating the new user, sign in the user
        final newUser = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(newUser);
      }

      // After successfully signing in or creating a new user
      final currentUser = _auth.currentUser;
      final userId = currentUser?.uid;

      //Navigator.push(
      //context,
      //MaterialPageRoute(
      //builder: (context) => HabitList(userId: userId!),
      //),
      //);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(userId: ''),
        ),
      );
    } on FirebaseAuthException catch (err) {
      print(err.message);
    }
  }

  //sign in with Google

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            color: const Color(0xFF2FD1C5).withOpacity(0.1),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("../images/logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Goal Keeper",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00394C),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Time to keep your goals innit?",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFF585A66)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 100,
                // ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            _isLogin ? "Login" : "Sign up",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2FD1C5),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            _isLogin
                                ? "Welcome back! Please login to your account"
                                : "Create your account now",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color(0xFF2FD1C5).withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                email = newValue!;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color(0xFF2FD1C5).withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.password),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 7) {
                                  return 'A password must be at least 7 characters long';
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                password = newValue!;
                              },
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: onValidate,
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: const Color(0xFF2FD1C5),
                              ),
                              child: Text(
                                !_isLogin ? "Sign up" : "Login",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Center(child: Text("Or")),
                          const SizedBox(width: 10),
                          Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: const Color(0xFF2FD1C5),
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _googleSignIn.signIn().then((userData) {
                                  setState(() {
                                    _isLogin = true;
                                    _userObj = userData!;
                                  });
                                }).catchError((e) {
                                  print(e);
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const HabitList(),
                                //   ),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: const Color(0xFF2FD1C5),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(!_isLogin
                              ? "Already have an account?"
                              : "Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                !_isLogin ? "Login" : "Sign up",
                                style:
                                    const TextStyle(color: Color(0xFF2FD1C5)),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
