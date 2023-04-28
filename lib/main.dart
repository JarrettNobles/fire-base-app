//      main.dart


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_signup_page.dart';
import 'p0_after_login.dart';
import 'p1_database_display.dart';
import 'p2_database_post.dart';
import 'p3_textfields_post.dart';
import 'p4_votes_display.dart';
// import other dart files here !!!


// FirebaseAuth fetches the authentication state of
// your user, such as whether they're logged in or
// logged out.
final FirebaseAuth auth = FirebaseAuth.instance;

const String _appTitle =    'Firebase Demo'    ;

var fBaseAppNavRoutes = <String, WidgetBuilder>{

  // in main.dart
  'first_screen'      : (context) => const MyHomePage(),

  // in p1_database_display.dart
  'view_notes_screen' : (context) =>
  const DatabaseDisplay1(),

  'view_hard_notes' : (context) =>
  const DatabasePost(),

  'view_textfield': (context) =>
const TextFieldsPost(),

  'votes' : (context) =>
      const VotesDisplay(),


  // add other screens here !!!

};


//     CONTINUE ON NEXT SCREEN


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    // use options only if your device is Chrome (web)
    // Get options values from
    // web/index.html's Firebase <script> ... </script>
    /*
    options: const FirebaseOptions(
                      apiKey:    ' Your API key here ',
                      projectId: ' Your project ID here',
            messagingSenderId:
                    '  Your messaging Sender Id here  ',
                      appId:      '  Your appId here  ',
    ), // FirebaseOptions
    */
  );

  runApp(const MyApp());
}  // main


class MyApp extends StatelessWidget {

  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: _appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialRoute: 'first_screen',
      routes: fBaseAppNavRoutes,
    );

  }

}     // end of MyApp

// CONTINUE ON NEXT PAGE

class MyHomePage  extends StatelessWidget {

  const MyHomePage ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar:  AppBar( title:
      const Text('Firebase Demo'),
      ),  // AppBar


      body:  StreamBuilder<User?>(

        stream: FirebaseAuth.instance.authStateChanges(),

        builder: _buildHomePageBody,

      ),


    );


  }


}   // end of MyHomePage Class


//   CONTINUE ON NEXT PAGE

Widget _buildHomePageBody(BuildContext context,
    AsyncSnapshot<User?> snapshot) {

  Widget body;

  if (snapshot.connectionState ==
      ConnectionState.waiting){

    body = _loadingDisplay();
  }

  else {
    if (snapshot.hasData){

      // User is still logged-in,
      // so go to
      // p0_after_login.dart
      body = AfterLoginDisplay(auth:   auth,
          fbUser: snapshot.data!);
    }
    else {
      // User needs to login or sign-up,
      // so go to
      // login_signup_page.dart
      body = LoginSignUpDisplay(auth: auth);
    }
  }

  return body;

}      // end of _buildHomePageBody



Widget _loadingDisplay (){

  return const Center(
    child: CircularProgressIndicator(),
  );
}

// --------- End of main.dart ----------





