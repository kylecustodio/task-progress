import 'package:flutter/material.dart';
import 'home.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Progress',
      theme: appTheme(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



