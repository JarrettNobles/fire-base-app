import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'data_model.dart';

class TextFieldsPost extends StatefulWidget {
  const TextFieldsPost({Key? key}) : super(key: key);

  @override
  State<TextFieldsPost> createState() => _TextFieldsPostState();
}

class _TextFieldsPostState extends State<TextFieldsPost> {
  final mainReference =
  FirebaseFirestore.instance.collection('notes').doc();
  final _titleController = TextEditingController();
  final _todoController = TextEditingController();
  String _entryInfo = '';

  @override
  void dispose() {
    _titleController.dispose();
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Post Page 2'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  labelText: 'Todo',
                ),
              ),
              ElevatedButton(
                onPressed: _postEntry,
                child: const Text(
                  'Submit TextField Entries to Firebase',
                ),
              ),
              ElevatedButton(
                onPressed: _clearFields,
                child: const Text(
                  'Clear',
                ),
              ),
              Text(
                _entryInfo,
                textScaleFactor: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _postEntry() {
    final title = _titleController.text.trim();
    final todo = _todoController.text.trim();
    if (title.isEmpty || todo.isEmpty) {
      setState(() {
        _entryInfo = 'No entry was submitted';
      });
    } else {
      final entry = NoteEntry(title, todo);
      mainReference.set(entry.toJson());
      setState(() {
        _entryInfo = 'Posted "$title" / "$todo"';
      });
    }
  }

  void _clearFields() {
    _titleController.clear();
    _todoController.clear();
    setState(() {
      _entryInfo = '';
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
