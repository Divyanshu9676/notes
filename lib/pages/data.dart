import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes3/pages/addata.dart';

class Data extends StatefulWidget {
  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  String title, content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Text("Add Notes"),
                  onPressed: () {
                    NoteAdd();
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                    child: Text("Title"),
                  ),
                  Expanded(
                    child: Text("Content"),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                      snapshot.data.documents[index];
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(documentSnapshot["Title"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot["Content"]),
                          ),
                        ],
                      );
                    }
                );
              },
            )
          ],
        ),
      ),
    );
  }
}