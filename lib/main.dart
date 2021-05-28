import 'package:covi_protect/Welcome/welcome.dart';
import 'package:covi_protect/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Welcome(),
    );
  }
}
