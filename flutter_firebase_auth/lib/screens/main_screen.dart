import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2FD1C5).withOpacity(0.1),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 100),
          Image.asset('../images/main.png'),
          const SizedBox(height: 30),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      height: 350,
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
                            Image.asset('../images/main_dots.png'),
                            const SizedBox(height: 120),
                            const Text(
                              'Task Manager',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              textAlign: TextAlign.center,
                              'Manage your class tasks and attendences easily and \nefficiently with Task Manager.Get started now!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 120),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2FD1C5),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
