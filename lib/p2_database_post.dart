//     p2_database_post.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'data_model.dart';

class DatabasePost extends StatefulWidget {

  const DatabasePost ({Key? key}) : super(key: key);

  @override
  State<DatabasePost> createState() =>
      _DatabasePostState();
}

class _DatabasePostState extends State<DatabasePost> {

  final mainReference =
  FirebaseFirestore.instance
      .collection('notes').doc();

  String _entryInfo = '';


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Database Post Page"),
      ),  // AppBar


      body: Padding(

        padding: const EdgeInsets.all(8.0),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,


          // CONTINUED ON THE NEXT PAGE

          children: <Widget>[

            Padding(
              padding: const EdgeInsets.all(8.0),

              child: ElevatedButton(
                onPressed: _postEntry,

                child: const
                Text('Submit Entry to Firebase'),
              ), // ElevatedButton
            ), // Padding

            Text(_entryInfo,
                textScaleFactor: 1.5),

          ], // <Widget>[]

        ), // Column

      ), // Padding

    ); // Scaffold
  }

  _postEntry( ) {

    NoteEntry entry =
    NoteEntry ("Mercer",  "Send Money");


    mainReference.set(entry.toJson());

    setState(() {

      _entryInfo =  'Posted "${entry.noteTitle}"'
          ' / '
          '"${entry.noteTodo}"';
    });
  }     // end of _postEntry()

}  // end of _DatabasePostState


