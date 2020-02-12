import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xff1f1f1f),
        accentColor: Colors.deepPurple[200],
        canvasColor: Color(0xff121212),
        cardColor: Color(0xff212121),
        errorColor: Color(0xffcf6679)
  );
}