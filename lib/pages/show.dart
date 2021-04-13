import 'package:flutter/material.dart';
import 'package:notes3/pages/database.dart';

// ignore: camel_case_types
class offline extends StatefulWidget {
  @override
  _offlineState createState() => _offlineState();
}

class _offlineState extends State<offline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Notes"),),
      body: Text(""),
    );
  }
}
