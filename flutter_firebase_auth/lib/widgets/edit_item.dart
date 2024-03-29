import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/data/categories.dart';
import 'package:flutter_firebase_auth/models/categories.dart';
import 'package:flutter_firebase_auth/models/habit_item.dart';
import 'package:http/http.dart' as http;

class EditItem extends StatefulWidget {
  final String userId;
  final HabitItem habitItem;

  const EditItem({super.key, required this.habitItem, required this.userId});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  Category? _selectedCategory;
  var _isSending = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.habitItem.title);
    _descriptionController =
        TextEditingController(text: widget.habitItem.description);
    _selectedCategory = widget.habitItem.category;
  }

  @override
  void dispose() {
    _titleController?.dispose();
    _descriptionController?.dispose();
    super.dispose();
  }

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          'flutter-firebase-auth-a5753-default-rtdb.firebaseio.com',
          'users/${widget.userId}/habit-items/${widget.habitItem.id}.json');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'title': _titleController?.text,
            'description': _descriptionController?.text,
            'category': _selectedCategory?.name,
          },
        ),
      );

      if (response.statusCode >= 400) {
        // Handle error
        return;
      }

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        HabitItem(
          id: widget.habitItem.id,
          title: _titleController?.text ?? '',
          description: _descriptionController?.text ?? '',
          category: _selectedCategory ?? categories[Categories.all]!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Goal',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF2FD1C5),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter the title of the item',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      _titleController?.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter the description of the item',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
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
                      _descriptionController?.text = value!;
                    },
                  ),
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
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: ElevatedButton(
                      onPressed: _isSending ? null : _saveItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2FD1C5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: _isSending
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Save Item',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
