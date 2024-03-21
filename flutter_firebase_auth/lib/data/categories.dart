import 'dart:ui';

import 'package:flutter_firebase_auth/models/categories.dart';

const categories = {
  Categories.all: Category(
      name: 'All',
      icon: 'assets/icons/all.svg',
      color: Color.fromRGBO(53, 102, 187, 1)),
  Categories.health: Category(
    name: 'Health',
    icon: 'assets/icons/health.svg',
    color: Color.fromRGBO(221, 35, 35, 1),
  ),
  Categories.academics: Category(
    name: 'Academics',
    icon: 'assets/icons/academics.svg',
    color: Color.fromRGBO(66, 119, 81, 1),
  ),
  Categories.faith: Category(
    name: 'Faith',
    icon: 'assets/icons/faith.svg',
    color: Color.fromRGBO(236, 252, 12, 1),
  ),
  Categories.relationships: Category(
    name: 'Relationships',
    icon: 'assets/icons/relationships.svg',
    color: Color.fromRGBO(91, 21, 127, 1),
  ),
  Categories.finance: Category(
    name: 'Finance',
    icon: 'assets/icons/finance.svg',
    color: Color.fromRGBO(20, 2, 2, 1),
  ),
  Categories.career: Category(
    name: 'Career',
    icon: 'assets/icons/career.svg',
    color: Color.fromRGBO(171, 33, 107, 0.926),
  ),
  Categories.personalGrowth: Category(
    name: 'Personal Growth',
    icon: 'assets/icons/personal-growth.svg',
    color: Color.fromRGBO(120, 106, 106, 1),
  ),
  Categories.hobbies: Category(
    name: 'Hobbies',
    icon: 'assets/icons/hobbies.svg',
    color: Color.fromRGBO(46, 198, 240, 1),
  ),
};
