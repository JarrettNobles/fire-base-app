//      p4_votes_display.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VotesDisplay extends StatelessWidget {

  const VotesDisplay ({Key? key}) : super(key: key);

  @override
  Widget build (BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Fruits Vote'),
      ), // AppBar

      body:Padding(

        padding: const EdgeInsets.all(8.0),

        child: StreamBuilder<QuerySnapshot>(

          stream:  FirebaseFirestore.instance
              .collection('fruits')
              .snapshots(),

          builder: _buildBody,

        ), // StreamBuilder,

      ), // Padding

    ); // Scaffold


  }      // end of build(..) method

  Widget _buildBody(BuildContext context,
      AsyncSnapshot<QuerySnapshot> snapshot) {

    Widget body;

    if (snapshot.hasData ){


      //   Retrieve list of Firebase documents in the
      //   contest collection
      List<DocumentSnapshot> listofDocuments =
          snapshot.data!.docs;


      // Use _buildListView method to build a ListView
      body = _buildListView(context, listofDocuments);

    } else {

      body = const Center(
        child: Text('Loading ... Please wait',
            textScaleFactor: 1.5),
        // or use LinearProgressIndicator()
      );

    }

    return body;

  }      // end of _buildBody(..) method



  Widget _buildListView(BuildContext context,
      List<DocumentSnapshot> listofDocuments) {

    return ListView.builder(

      itemCount: listofDocuments.length,
      itemBuilder: (context, index) =>
          _buildListItem(context, index,
              listofDocuments),
    );

  }      // end of _buildListView(..)

  Widget _buildListItem(BuildContext context, int index,
      List<DocumentSnapshot> listofDocuments) {

    DocumentSnapshot fBaseDocument =
    listofDocuments [index];

    String fruitName = fBaseDocument['name'];


    int     numVotes = fBaseDocument['votes'];

    return Row(

      children: <Widget>[

        Padding(

          padding: const EdgeInsets.all(8.0),

          child: ElevatedButton(

            onPressed: () =>
                _updateVoteUsingAtomicIncrement(fBaseDocument),


            child: Text(fruitName),
          ), // ElevatedButton

        ), // Padding

        Text('Number of votes: ${numVotes.toString()}',

            textScaleFactor: 1.5),

      ], // <Widget>[]
    ); // Row

  }   // end of _buildListItem

  //         CONTINUE ON NEXT PAGE
  _updateVoteUsingAtomicIncrement(
      DocumentSnapshot fBaseDocument){

    DocumentReference docRef = fBaseDocument.reference;

    docRef.update   ( {'votes':
    FieldValue.increment(1) });

  }   // end of _updateVoteUsingAtomicIncrement
// end of _updateVote


}  // end of VotesDisplay class


//  end of  p4_votes_display.dart
