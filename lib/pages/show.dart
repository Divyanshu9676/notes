import 'package:flutter/material.dart';
import 'package:notes3/pages/database.dart';

// ignore: camel_case_types
class offline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OFFLINE data'),
      ),
      body: FutureBuilder<List>(
        future: Databasehelper.instance.getAllRecords("MyTable"),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, int position) {    //Creates a scrollable, linear array of widgets that are created on demand.
                return Card(
                  child: ListTile(
                    title: Text(snapshot.data[position].row[0]),
                    subtitle: Text(snapshot.data[position].row[1]),
                ),
              );
            },
          )
              : Text("ERROR occurred");
        },
      ),
    );
  }
}