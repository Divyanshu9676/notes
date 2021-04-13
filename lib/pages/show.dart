import 'package:flutter/material.dart';
import 'package:notes3/pages/database.dart';

class offline extends StatelessWidget {
  var a = Databasehelper.instance.queryAll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),),
      body: Center(
        child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("Show offline data"),
                onPressed: () async {print(await a);},
              ),
            ]
        )
      )
    );
  }
}

