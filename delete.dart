import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  TextEditingController name = TextEditingController();
  String n;

  deleteData() {
    n=name.text;
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyData").doc("$n");

    documentReference.delete().whenComplete(() {
      Text("$name deleted");
    }).whenComplete(() => Navigator.pop(context));
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
            TextField(
                controller: name,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'title to delete',
                  border: OutlineInputBorder(),
                )),
            RaisedButton(
              child: Text("Confirm Delete"),
              onPressed: () {deleteData();},
            )
          ],
        ),
      ),
    );
  }
}