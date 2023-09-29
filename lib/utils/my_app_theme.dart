import 'package:flutter/material.dart';

class MyAppTheme {
  static ThemeData get themeData {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff0a0e21),
        shadowColor: Colors.white,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyLarge: const TextStyle(fontFamily: 'Schyler'),
            bodyMedium: const TextStyle(fontFamily: 'Schyler'),
            titleLarge: const TextStyle(
              fontFamily: 'Schyler',
              fontSize: 20,
            ),
          ),
    );
  }
}
