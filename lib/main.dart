import 'package:flutter/material.dart';
import 'package:task_progress/screens/home.dart';
import 'package:task_progress/values/style.dart';

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



