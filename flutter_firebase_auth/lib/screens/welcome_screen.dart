import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/signup_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color(0xFF2FD1C5).withOpacity(0.1),
          child: SingleChildScrollView(
            // Makes the column scrollable
            child: Column(
              children: [
                const SizedBox(height: 100),
                Image.asset(
                    'images/main.png'), // Ensure this image file is added in your project assets
                const SizedBox(height: 30),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Image.asset(
                            'images/main_dots.png'), // Ensure this image file is added in your project assets
                        const SizedBox(
                            height: 20), // Adjusted height for better spacing
                        const Text(
                          'Goal Keeper',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Adjusted height for better spacing
                        const Text(
                          '"I am not really a Goal Keeper,\nI am just here to keep your goals for you."\n - said by a Goal Keeper.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Adjusted height for better spacing
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2FD1C5),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height:
                                30), // Added spacing at the bottom for better layout
                      ],
                    ),
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
