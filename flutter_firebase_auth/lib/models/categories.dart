import 'package:flutter/material.dart';

enum Categories {
  all,
  health,
  academics,
  faith,
  relationships,
  finance,
  career,
  personalGrowth,
  hobbies,
}

class Category {
  const Category({required this.name, required this.icon, required this.color});

  final String name;
  final String icon;
  final Color color;
}
