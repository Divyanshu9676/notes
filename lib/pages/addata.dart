import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteAdd extends StatefulWidget {
  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  String title, content;

  gettitle(name) {
    this.title = name;
  }

  getbody(body) {
    this.content = body;
  }

  createData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyData").doc("user1");

    // create Map
    Map<String, dynamic> students = {
      "studentName": title,
      "studentID": content,
    };

    documentReference.set(students).whenComplete(() {
      print("$title note_created");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",),
                onChanged: (String name) {
                  gettitle(name);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Body",),
                onChanged: (String body) {
                  getbody(body);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Create"),
                  onPressed: () {
                    createData();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}