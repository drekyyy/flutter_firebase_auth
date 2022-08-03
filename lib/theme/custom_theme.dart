import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        // fontFamily: 'Roboto',
        canvasColor: Colors.green.shade900,
        backgroundColor: Colors.green.shade900,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green.shade900),
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white))),
        appBarTheme: AppBarTheme(
            actionsIconTheme: const IconThemeData(color: Colors.white),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green.shade900,
            elevation: 0),
        textTheme: const TextTheme(
            bodyText2: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white)),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color.fromARGB(255, 27, 94, 32)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade900)),
        ),
        drawerTheme: const DrawerThemeData(elevation: 0),
        iconTheme: const IconThemeData(color: Colors.white),
        dialogTheme: DialogTheme(
            backgroundColor: Colors.green.shade900,
            titleTextStyle: const TextStyle(color: Colors.white)));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        // fontFamily: 'Roboto',
        canvasColor: Colors.green.shade900,
        backgroundColor: Colors.green.shade900,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.white))),
        appBarTheme:
            AppBarTheme(backgroundColor: Colors.green.shade900, elevation: 0),
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.green.shade900),
            subtitle1: const TextStyle(color: Color.fromARGB(255, 27, 94, 32))),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Color.fromARGB(255, 27, 94, 32)),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF1B5E20), width: 2.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color.fromARGB(255, 27, 94, 32), width: 2.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.green.shade900)),
        ),
        drawerTheme: const DrawerThemeData(elevation: 0),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}
