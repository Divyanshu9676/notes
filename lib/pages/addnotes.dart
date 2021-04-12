import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes3/pages/updatenotes.dart';
import 'package:notes3/pages/delete.dart';

class Snote extends StatefulWidget {
  @override
  _SnoteState createState() => _SnoteState();
}

class _SnoteState extends State<Snote> {
  DocumentReference documentReference =
  FirebaseFirestore.instance.collection("MyData").doc("Notes");


  readData() {
    documentReference.get().then((datasnapshot) {
      Text(datasnapshot.data()["title"]);
      Text(datasnapshot.data()["content"]);
    });
  }

  deleteData() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Delete()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("MyData").snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      onTap: () {deleteData();},),
                    Center(
                        child: RaisedButton(
                            child: Text("Add Notes"),
                            onPressed: () {Navigator.push(
                                context, MaterialPageRoute(builder: (context) => Addnote()));}
                        ),
                    ),
                    RaisedButton(
                        child: Text("Delete"),
                        onPressed: () {deleteData();}
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}