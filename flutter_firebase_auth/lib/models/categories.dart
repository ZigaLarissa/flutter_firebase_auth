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
  const Category(
      {required this.name, required this.image, required this.color});

  final String name;
  final String image;
  final Color color;
}
