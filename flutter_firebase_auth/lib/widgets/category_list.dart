import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/data/categories.dart';
import 'package:flutter_firebase_auth/models/categories.dart';
import 'package:flutter_firebase_auth/widgets/habit_list.dart';
import 'package:flutter_firebase_auth/widgets/new_item.dart';

class CategoryList extends StatelessWidget {
  final String userId;
  const CategoryList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.values.length,
      itemBuilder: (context, index) {
        Category category = categories.values.toList()[index];
        return Container(
          height: 60,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(color: category.color),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 8, right: 8),
                leading: Image.asset(category.image),
                title: Text(category.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitList(
                        userId: userId,
                        selectedCategory: category,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
