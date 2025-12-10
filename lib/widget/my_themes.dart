import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData customLightTheme = ThemeData.light().copyWith(
    textTheme: ThemeData.light().textTheme.copyWith(
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final ThemeData customDarkTheme = ThemeData.dark().copyWith(
    textTheme: ThemeData.dark().textTheme.copyWith(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
