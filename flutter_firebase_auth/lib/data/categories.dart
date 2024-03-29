import 'dart:ui';

import 'package:flutter_firebase_auth/models/categories.dart';

const categories = {
  Categories.all: Category(
    name: 'All',
    image: 'images/all.png',
    color: Color(0xFF8BE38B),
  ),
  Categories.health: Category(
    name: 'Health',
    image: 'images/health.png',
    color: Color(0xFFB3B4F7),
  ),
  Categories.academics: Category(
    name: 'Academics',
    image: 'images/academics.png',
    color: Color(0xFF93B5FF),
  ),
  Categories.faith: Category(
    name: 'Faith',
    image: 'images/faith.png',
    color: Color(0xFFE48FFF),
  ),
  Categories.relationships: Category(
    name: 'Relationships',
    image: 'images/relationship.png',
    color: Color(0xFFE8FEE4),
  ),
  Categories.finance: Category(
    name: 'Finance',
    image: 'images/finance.png',
    color: Color(0xFFF9B54C),
  ),
  Categories.career: Category(
    name: 'Career',
    image: 'images/career.png',
    color: Color(0xFFFF7058),
  ),
  Categories.personalGrowth: Category(
    name: 'Personal Growth',
    image: 'images/growth.png',
    color: Color(0xFFBA7958),
  ),
  Categories.hobbies: Category(
    name: 'Hobbies',
    image: 'images/hobbies.png',
    color: Color(0xFFE6E9EE),
  ),
};
