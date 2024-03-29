import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/widgets/category_list.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Choose Category",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2FD1C5),
              ),
            ),
            const Text(
              textAlign: TextAlign.left,
              "Select a category to get started with your goals filtering. \n Filter your goals by category to get a better view of your goals.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: CategoryList(userId: userId),
            ),
          ],
        ),
      ),
    );
  }
}
