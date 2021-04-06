import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Addnote extends StatefulWidget {
  @override
  _AddnoteState createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  final hea = TextEditingController();
  final con = TextEditingController();

  void addData(String head,String content) {
    DocumentReference ref =
    FirebaseFirestore.instance.collection("MyData").doc("Notes");
    ref.set({
      'title': head,
      'content': content
    }).whenComplete(() => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),),
        body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 250.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                          controller: hea,
                          decoration: InputDecoration(hintText: 'Heading',)
                      ),
                    ),
                    SizedBox(height: 250.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                          controller: con,
                          decoration: InputDecoration(hintText: 'Content',)
                      ),
                    ),
                    Center(
                        child: RaisedButton(
                            child: Text("Save the NOTE"),
                            onPressed: () {
                              addData(hea.text,con.text);}
                        )
                    ),
                  ],
                ),
        ));
  }
}