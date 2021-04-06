import 'package:flutter/material.dart';
import 'package:notes3/pages/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Creates and initializes the binding (interact with the Flutter engine).
  await Firebase.initializeApp(); // to connect Firebase with Flutter we have to initialise Firebase before using it.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: AuthScreen(),
    );
  }
}