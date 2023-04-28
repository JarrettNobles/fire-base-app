//     p1_database_display.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseDisplay1 extends StatelessWidget {

  const DatabaseDisplay1 ({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Database Display Page 1"),
      ),  // AppBar

      body: StreamBuilder<QuerySnapshot>(

        stream:
        FirebaseFirestore.instance
            .collection( 'notes').snapshots(),
        builder: _buildBody,

      ), // StreamBuilder
    );   // Scaffold
  }

  Widget _buildBody(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {

    Widget body;

    if (snapshot.hasData ){

      // Retrieve list of Firebase    documents
      List<DocumentSnapshot> documentsList =
          snapshot.data!.docs;


      // Use _buildListView method to build a ListView
      body = _buildListView(context, documentsList);

    } else {

      body = const Center(
        child: Text('Loading .. Please wait	',
            textScaleFactor: 1.5),
        // or use LinearProgressIndicator()
      );
    }

    return body;
  }

  Widget _buildListView(BuildContext context,
      List<DocumentSnapshot> documentsList) {

    return ListView.builder(

      itemCount: documentsList.length				,
      itemBuilder: (context, index) =>
          _buildListItem(context, index,
              documentsList),
    );
  }

  Widget _buildListItem(BuildContext context, int index,
      List<DocumentSnapshot> documentsList) {

    DocumentSnapshot ds = documentsList[index];

    return ListTile(

      // parse 'title' field from document
      title: Text(ds['title']),

      // parse 'todo' field from document, with "todo:" text added
      subtitle: Text("todo: ${ds['todo']}"),

    );

  }



}  // end of DatabaseDisplay1
