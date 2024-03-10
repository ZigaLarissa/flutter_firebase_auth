import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/habit_item.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_firebase_auth/data/categories.dart';
import 'package:flutter_firebase_auth/models/categories.dart';
// import 'package:flutter_firebase_auth/models/habit_item.dart';

class NewItem extends StatefulWidget {
  final String userId;
  const NewItem({super.key, required this.userId});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredDescription = '';
  var _selectedCategory = categories[Categories.all]!;
  var _isSending = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'flutter-firebase-auth-a5753-default-rtdb.firebaseio.com',
          'users/${widget.userId}/habit-items.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'title': _enteredName,
            'description': _enteredDescription,
            'category': _selectedCategory.name,
          },
        ),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        HabitItem(
          id: responseData['name'],
          title: _enteredName,
          description: _enteredDescription,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a New Item')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter the title of the item',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Must be between 1 and 50 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredName = value!;
                    }),
                TextFormField(
                    maxLength: 100,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter the description of the item',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 100) {
                        return 'Must be between 1 and 100 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredDescription = value!;
                    }),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 8),
                                Text(category.value.name),
                              ],
                            ),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset Item'),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Save Item'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
