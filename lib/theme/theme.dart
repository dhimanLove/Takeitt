import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    elevation: 0.0,
  ),
  brightness: Brightness.dark,
  colorScheme:
  const ColorScheme(
      surface: Colors.black,
      brightness: Brightness.dark,
    onSurface: Colors.white,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.blue,
    tertiary: Colors.white,
    surfaceTint: Colors.black12,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:WidgetStatePropertyAll(
        Colors.white,
      ),
      foregroundColor: WidgetStatePropertyAll(
        Colors.black,
      ),
    )
  )
);