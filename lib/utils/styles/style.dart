import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF5F627D),
      onPrimary: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.black),
    backgroundColor: Color(0xFF5F627D),
  ),
);

InputDecoration buildInputDecoration(String labelText, String hintText) {
  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: UnderlineInputBorder(borderSide: BorderSide(width: 16)),
  );
}
