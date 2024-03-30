import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/widgets/category_list.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Calculate the width based on the screen size, if needed
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            // Makes the column scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                const Text(
                  "Choose Category",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 7, 7),
                  ),
                ),
                const SizedBox(height: 8), // Add some spacing between the texts
                const Text(
                  "Filter your goals by category to get a better view of your goals.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(
                    height: 20), // Additional spacing before the list starts
                // Adjusting or removing width, depending on CategoryList's requirements
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: screenWidth - 40), // Padding accounted
                  child: CategoryList(userId: userId),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
