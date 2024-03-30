import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_firebase_auth/screens/home_screen.dart';
import 'package:flutter_firebase_auth/widgets/category_list.dart';
import 'package:mockito/mockito.dart'; // If you're using Mockito for mocking dependencies

// A mock class for your CategoryList, if necessary. This is useful if CategoryList depends on external data.
class MockCategoryList extends StatelessWidget {
  final String userId;

  const MockCategoryList({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock implementation or simply return a container for testing layout
    return Container();
  }
}

void main() {
  // This group collects multiple tests for HomeScreen
  group('HomeScreen Tests', () {
    // A test to ensure the HomeScreen widget builds correctly
    testWidgets('HomeScreen builds its UI correctly',
        (WidgetTester tester) async {
      // Define the test key
      const testKey = Key('homeScreenTest');

      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: HomeScreen(key: testKey, userId: 'testUserId'),
        ),
      ));

      // Verify that HomeScreen is displayed
      expect(find.byKey(testKey), findsOneWidget);

      // Verify that the "Choose Category" text is displayed
      expect(find.text('Choose Category'), findsOneWidget);

      // Verify that the CategoryList widget is present
      // This assumes CategoryList is a significant widget to test for its presence
      expect(find.byType(CategoryList), findsOneWidget);
    });

    // Add more tests as needed for different aspects of the HomeScreen
  });
}
