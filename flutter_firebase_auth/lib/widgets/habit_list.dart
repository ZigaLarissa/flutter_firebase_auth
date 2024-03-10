import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/data/categories.dart';
import 'package:flutter_firebase_auth/widgets/edit_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_firebase_auth/models/habit_item.dart';
import 'package:flutter_firebase_auth/widgets/new_item.dart';

class HabitList extends StatefulWidget {
  final String userId;

  const HabitList({super.key, required this.userId});

  @override
  State<HabitList> createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  List<HabitItem> _habitItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems();
  }

  void _loadedItems() async {
    final url = Uri.https(
        'flutter-firebase-auth-a5753-default-rtdb.firebaseio.com',
        'users/${widget.userId}/habit-items.json');
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Couldn\'t fetch data from the server, try again later.';
      });
    }

    if (response.body != 'null') {
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<HabitItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.name == item.value['category'])
            .value;
        loadedItems.add(
          HabitItem(
            id: item.key,
            title: item.value['title'],
            description: item.value['description'],
            category: category,
          ),
        );
      }

      setState(() {
        _habitItems = loadedItems;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<HabitItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(
          userId: widget.userId,
        ),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _habitItems.add(newItem);
    });
  }

  void _removeItem(String id) {
    final url = Uri.https(
        'flutter-firebase-auth-a5753-default-rtdb.firebaseio.com',
        'users/${widget.userId}/habit-items/$id.json');

    http.delete(url);
    setState(() {
      _habitItems.removeWhere((element) => element.id == id);
    });
  }

  //edit item
  void _editItem(HabitItem habitItem) async {
    final editedItem = await Navigator.of(context).push<HabitItem>(
      MaterialPageRoute(
        builder: (context) =>
            EditItem(habitItem: habitItem, userId: widget.userId),
      ),
    );

    if (editedItem != null) {
      setState(() {
        final index =
            _habitItems.indexWhere((item) => item.id == editedItem.id);
        _habitItems[index] = editedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items yet!'),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_habitItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _habitItems.length,
        itemBuilder: (context, index) {
          final habitItem = _habitItems.elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: habitItem.category.color.withOpacity(0.2),
              child: Dismissible(
                onDismissed: (direction) {
                  _removeItem(habitItem.id);
                },
                key: ValueKey(habitItem.id),
                child: ListTile(
                  title: Text(habitItem.title),
                  subtitle: Text(habitItem.description),
                  leading: CircleAvatar(
                    backgroundColor: habitItem.category.color,
                    child: IconButton(
                        onPressed: () {
                          _removeItem(habitItem.id);
                        },
                        icon: const Icon(Icons.check)),
                  ),
                  trailing: SizedBox(
                    child: IconButton(
                        onPressed: () {
                          _editItem(habitItem);
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                  onLongPress: () {
                    _editItem(habitItem);
                  },
                ),
              ),
            ),
          );
        },
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Habits'), actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ]),
        body: content,
      ),
    );
  }
}
