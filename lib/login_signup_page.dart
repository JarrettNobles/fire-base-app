//      login_signup_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// txtFieldBtnClicked (enum) manages the screen’s state
// There are 2 states: loginBtn and createAccountBtn

// If the user clicks the Login button, it logs a
// valid user in.

// If the user clicks the "Create an Account" button,
// it creates a new account and logs the user in.
enum TxtFieldBtnClicked { loginBtn, createAccountBtn, logOutBtn }

class LoginSignUpDisplay extends StatefulWidget {

  const LoginSignUpDisplay ({Key? key,
    required this.auth }) :
        super(key: key);

  final FirebaseAuth auth;

  @override
  State< LoginSignUpDisplay>    createState() =>
      _LoginSignUpState();
}



class _LoginSignUpState extends State<LoginSignUpDisplay> {

  String? fbEmail    = '';
  String? fbPassword = '';

  // Create a global key that uniquely identifies the
  // Form widget
  // and allows validation of the form
  final formKey = GlobalKey<FormState>();


//  CONTINUE ON THE NEXT PAGE


  @override
  Widget build (BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(8.0),

      child: Form(

        key: formKey,

        child: ListView(

          children: <Widget>[

            TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              // autofocus: false,

              decoration: const InputDecoration(
                  hintText: 'Email',
                  icon: Icon(
                    Icons.mail,
                    color: Colors.grey,
                  ) // Icon
              ), // InputDecoration

              validator: (emailInput){    // checks input
                if (emailInput!.contains('@')){
                  return null;
                }
                else{
                  return 'Not a valid email.';
                }
              },

              onSaved: (emailInput) =>
              fbEmail = emailInput,
            ), // TextFormField


//   CONTINUE ON NEXT PAGE

            TextFormField(
              maxLines: 1,
              obscureText: true,
              // autofocus: false,

              decoration: const InputDecoration(
                hintText: 'Password',
                icon: Icon(
                  Icons.lock,
                  color: Colors.grey,
                ), // Icon
              ), // InputDecoration

              validator: (passWordInput){    // checks
                // input
                if (passWordInput!.length < 6){
                  return 'Password too short.';
                }
                else{
                  return null;
                }
              },

              onSaved: (passWdInput) =>
              fbPassword = passWdInput,
            ), // TextFormField

            Padding(

              padding: const EdgeInsets.all(8.0),

              child: MaterialButton(
                elevation: 5.0,
                minWidth: 200.0,
                height: 42.0,
                color: Colors.blue,
                child: const Text('Login',
                  style: TextStyle(fontSize: 20.0,
                      color: Colors.white),
                ), // Text
                onPressed: () =>
                    _submit (TxtFieldBtnClicked.loginBtn),
              ), //MaterialButton
            ), // Padding

//  CONTINUE ON NEXT PAGE

            TextButton(
              child: const Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () => _submit(TxtFieldBtnClicked.createAccountBtn),
            )
            , // TextButton

          ], // <Widget>[]

        ), // ListView

      ), // Form

    ); // Padding
  }


  void _submit(TxtFieldBtnClicked btnClicked) {
    final form = formKey.currentState;

    if (form != null) {

      if (form.validate()) {

        // Email & password matched our validation rules
        // and are saved to _email and _password fields.
        form.save();

        if (btnClicked == TxtFieldBtnClicked.loginBtn) {
          logInUser();
        } else if (btnClicked == TxtFieldBtnClicked.createAccountBtn) {
          createNewUser();
        } else if (btnClicked == TxtFieldBtnClicked.logOutBtn) {
          logOutUser();
        }

      }   // end of form.validate

    }

  }

//    CONTINUE ON NEXT PAGE

  void logInUser() async {

    try {
      await widget.auth.signInWithEmailAndPassword(
          email:    fbEmail!,
          password: fbPassword!);
    } catch (e) {
      if (kDebugMode) {  // print out error if code is
        // in debug mode
        print(e.toString());
      }
    } finally {
      //
    }
  }


  void createNewUser() async {

    try {
      await widget.auth.createUserWithEmailAndPassword(
        email:    fbEmail!,
        password: fbPassword!,
      );

    } catch (e) {
      if (kDebugMode) {  // print out error if code is
        // in debug mode
        print(e.toString());
      }

    } finally {
      //
    }
  }

  void logOutUser() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }


} // end of _LoginSignUpState


// -------  End of login_signup_page.dart ----
