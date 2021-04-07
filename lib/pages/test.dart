import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes3/pages/updatenotes.dart';
import 'package:notes3/pages/delete.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String title, content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Title"),
                  ),
                  Expanded(
                    child: Text("Body"),
                  ),
                ],
              ),
            ),
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
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(documentSnapshot["title"]),
                            ),
                            Expanded(
                              child: Text(documentSnapshot["content"]),
                            ),
                          ],
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}