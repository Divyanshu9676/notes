import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes3/pages/addnotes.dart';
import 'package:notes3/pages/data.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreen createState() => _AuthScreen();
}

class _AuthScreen extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; //firebaseauth libray ka instance
  final GoogleSignIn _googleSignIn = GoogleSignIn(); //goglesignin function ka instance

  Future<void> handleSignIn(BuildContext context) async {
    final GoogleSignInAccount account = await _googleSignIn.signIn(); //instance ka method
    final GoogleSignInAuthentication gSA = await account.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    await _auth.signInWithCredential(credential);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Snote()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () {handleSignIn(context);},
                ),
              ]
          ),),),

    );
  }
}