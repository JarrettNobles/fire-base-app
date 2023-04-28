import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_signup_page.dart';

class AfterLoginDisplay extends StatelessWidget {

  const AfterLoginDisplay ({Key? key,
    required this.auth,
    required this.fbUser }) :
        super(key: key);
  final FirebaseAuth auth;
  final User         fbUser;

  @override
  Widget build(BuildContext context) {

    return _afterLoginPageBody(context);

  }

  Widget  _afterLoginPageBody (BuildContext  context) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[

        Padding (
          padding: const EdgeInsets.all(8.0),
          child: Text("User: ${fbUser.email}"),
        ),

        Padding (

          padding: const EdgeInsets.all(8.0),

          child: ElevatedButton(
            child:  const Text("View Notes"),

            onPressed:  () {
              Navigator.pushNamed(context,
                  'view_notes_screen');
            },
          ), // ElevatedButton

        ),  // Padding

//  CONTINUE ON NEXT PAGE

        Padding (
          padding: const EdgeInsets.fromLTRB(8.0, 0.0,
              8.0, 8.0),
          child: ElevatedButton(
            child:  const Text("Post Hard-coded Note"),
            onPressed:  () {
              Navigator.pushNamed(context,
                  'view_hard_notes');
              // Go to "Mercer/Send Money Page"
            },
          ), // ElevatedButton
        ),  // Padding


        Padding (
          padding: const EdgeInsets.fromLTRB(8.0, 0.0,
              8.0, 8.0),
          child: ElevatedButton(
            child:  const Text("Post User-entered Note"),
            onPressed:  () {
              Navigator.pushNamed(context,
                  'view_textfield');
              // Go to the page that has
              // two TextFields
            },
          ), // ElevatedButton
        ),  // Padding


        Padding (
          padding: const EdgeInsets.fromLTRB(8.0, 0.0,
              8.0, 8.0),
          child: ElevatedButton(
            child:  const Text("Fruits Vote"),
            onPressed:  () {
              Navigator.pushNamed(context,
                  'votes');
              // Go to the Fruits vote page
            },
          ), // ElevatedButton
        ),
        Padding (
          padding: const EdgeInsets.fromLTRB(8.0, 0.0,
              8.0, 8.0),
          child: ElevatedButton(
            child:  const Text("Logout"),
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut();
                // Navigate to login page or wherever you want to go after logout
              } catch (e) {
                print(e.toString());
              }
            },
          ), // ElevatedButton
        ), // Padding

      ],    // <Widget>[]

    );  // return

  }

}
