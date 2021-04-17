import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes3/pages/updatenotes.dart';
import 'package:notes3/pages/auth.dart';
import 'package:notes3/pages/delete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String title, content;

  void signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MyData").snapshots(),//pathway
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true, //unlimited data
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                        return Card(
                          child: ListTile(
                            title: Text(documentSnapshot["title"]),
                            subtitle: Text(documentSnapshot["content"]),
                          ),
                        );
                      });
                } else {
                  return Text(snapshot.error.toString());
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("Create"),
                  onPressed: () {Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Addnote()));
                  },
                ),
                RaisedButton(
                  child: Text("Delete"),
                  onPressed: () {Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Delete()));
                  },
                ),
                RaisedButton(
                  child: Text("SignOut"),
                  onPressed: () {signOut();},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}