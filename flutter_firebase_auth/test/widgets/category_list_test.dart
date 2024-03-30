import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_firebase_auth/widgets/category_list.dart';
import 'package:flutter_firebase_auth/models/categories.dart';
import 'package:flutter_firebase_auth/widgets/habit_list.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('CategoryList Widget Tests', () {
    // Setup NavigatorObserver mock
    final mockObserver = MockNavigatorObserver();

    // Create a common setup for the widget
    Future<void> _buildCategoryList(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: CategoryList(userId: 'testUserId')),
        navigatorObservers: [mockObserver],
      ));
    }

    testWidgets('Displays list of categories', (WidgetTester tester) async {
      await _buildCategoryList(tester);

      // Verify that list items are present for each category
      for (var category in categories.values) {
        expect(find.text(category.name), findsOneWidget);
      }
    });

    testWidgets('Navigates to HabitList on list item tap',
        (WidgetTester tester) async {
      await _buildCategoryList(tester);

      // Tap the first list item
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      // Verify that navigation to HabitList was triggered
      verify(mockObserver.didPush(any, any));
    });
  });
}
