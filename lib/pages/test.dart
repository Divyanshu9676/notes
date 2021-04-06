import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes3/pages/updatenotes.dart';

class Snote extends StatefulWidget {
  @override
  _SnoteState createState() => _SnoteState();
}

class _SnoteState extends State<Snote> {
  DocumentReference documentReference =
  FirebaseFirestore.instance.collection("MyData").doc("Notes");


  readData() {
    documentReference.get().then((datasnapshot) {
      print(datasnapshot.data()["title"]);
      print(datasnapshot.data()["content"]);
    });
  }

  deleteData() {
    documentReference.delete();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("MyData").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document['name']),
                subtitle: new Text(document['phone']),
                  onTap: () {deleteData();}
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class DriverList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return new StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('DriverList').snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData) return new Text('Loading...');
      return new ListView(
        children: snapshot.data.docs.map((DocumentSnapshot document) {
          return new ListTile(
            title: new Text(document['name']),
            subtitle: new Text(document['phone']),
          );
        }).toList(),
      );
    },
  );
}}

