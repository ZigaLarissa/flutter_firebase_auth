import 'package:flutter_firebase_auth/models/categories.dart';

class HabitItem {
  const HabitItem(
      {required this.id,
      required this.title,
      required this.description,
      required this.category});

  final String id;
  final String title;
  final String description;
  final Category category;
}
