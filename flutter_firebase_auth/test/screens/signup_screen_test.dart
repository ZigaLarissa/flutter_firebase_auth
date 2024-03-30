import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

// Generate mock classes using mockito
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  // Initialize the mock objects
  MockFirebaseAuth mockAuth;
  MockGoogleSignIn mockGoogleSignIn;

  setUp(() {
    // Instantiate mock objects before each test
    mockAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
  });

  group('SignupPage Tests', () {
    testWidgets('Renders SignupPage and finds Text Widgets',
        (WidgetTester tester) async {
      // Provide MaterialApp with a Mocked version of SignupPage that uses mockAuth and mockGoogleSignIn
      // Note: You'll need to adjust your SignupPage to accept mockAuth and mockGoogleSignIn as parameters for testing purposes

      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Verify that certain Text widgets appear on screen.
      expect(find.text('Goal Keeper'), findsOneWidget);
      expect(find.text('Time to keep your goals innit?'), findsOneWidget);
      expect(find.text('Sign up'),
          findsWidgets); // Because it appears more than once
      expect(find.text('Login'),
          findsWidgets); // Appears in the toggle button at least
    });

    testWidgets('Toggles between Sign up and Login states',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignupPage()));

      // Initially in sign up state
      expect(find.text('Sign up'), findsWidgets);
      expect(find.text('Login'), findsWidgets); // The toggle button

      // Tap on the 'Login' text button to switch mode
      await tester.tap(find.text('Login').last);
      await tester.pump();

      // Now in login state
      expect(find.text('Login'), findsWidgets); // The main button now
      expect(find.text('Sign up'), findsWidgets); // The toggle button
    });

    // Additional tests can be added here, including mocking and verifying interactions with FirebaseAuth and GoogleSignIn
  });
}
