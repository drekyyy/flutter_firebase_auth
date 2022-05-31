import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      canvasColor: Colors.green.shade200,
      backgroundColor: Colors.green.shade200,
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.green.shade200, elevation: 0),
      textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.green.shade200),
          subtitle1: TextStyle(color: Color.fromARGB(255, 165, 214, 167))),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color.fromARGB(255, 165, 214, 167)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 165, 214, 167), width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 165, 214, 167), width: 2.0))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green.shade200)),
      ),
      drawerTheme: const DrawerThemeData(elevation: 0),
    );
  }
}
