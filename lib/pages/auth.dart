import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes3/pages/test.dart';
import 'package:notes3/pages/database.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreen createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(); //Initializes global sign-in configuration settings



  Future<void> handleSignIn(BuildContext context) async {
    final GoogleSignInAccount account = await _googleSignIn.signIn(); //instance ka method
    final GoogleSignInAuthentication gSA = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    await _auth.signInWithCredential(credential);
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Test()));
    }else{Navigator.push(
        context, MaterialPageRoute(builder: (context) => Databasehelper()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () {handleSignIn(context);},
                ),
              ]
          ),
      ),
    );
  }
}