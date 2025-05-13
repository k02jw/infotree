import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFFB2FF59), // 진짜 연두색 느낌 (형광 연두)
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // 연한 연두 AppBar
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black87,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade200,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    hintStyle: const TextStyle(color: Colors.grey),
    prefixIconColor: Colors.grey,
  ),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(fontSize: 16, color: Colors.black87),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.grey[800],
    ),
  ),
  iconTheme: IconThemeData(color: Colors.grey[800]),
  dividerColor: Colors.grey[300],
  cardColor: Colors.white,
);
