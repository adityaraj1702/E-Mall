import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: Colors.amber,
    backgroundColor: Colors.white,
    cardColor: Colors.white,
    errorColor: Colors.red,
  ),
  scaffoldBackgroundColor: Colors.white,
  canvasColor: Colors.grey[50],

  // Text Theme
  textTheme: TextTheme(
    displayLarge: const TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: const TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
    displaySmall: const TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineLarge: const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineSmall: const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleLarge: const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
    titleSmall: TextStyle(fontSize: 10.0, color: Colors.grey[700]),
    bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.black),
    bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.black),
    bodySmall: const TextStyle(fontSize: 12.0, color: Colors.black),
    labelLarge: const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
    labelSmall: TextStyle(fontSize: 10.0, color: Colors.grey[700]),
  ),

  // AppBar Theme
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    elevation: 4,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(color: Colors.white),
  ),

  // Button Theme
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.blue),
    ),
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Colors.grey[300],
    thickness: 1,
  ),

  // Card Theme
  cardTheme: CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[300],
    disabledColor: Colors.grey[100],
    selectedColor: Colors.blue[300],
    secondarySelectedColor: Colors.blue[200],
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    labelStyle: const TextStyle(color: Colors.black),
    secondaryLabelStyle: const TextStyle(color: Colors.white),
    brightness: Brightness.light,
  ),

  // Tab Bar Theme
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 16),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blueGrey,
    accentColor: Colors.tealAccent,
    backgroundColor: Colors.black,
    cardColor: Colors.grey[850],
    errorColor: Colors.red,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black,
  canvasColor: Colors.grey[900],

  // Text Theme
  textTheme: TextTheme(
    displayLarge: const TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: const TextStyle(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
    displaySmall: const TextStyle(
        fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineLarge: const TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(fontSize: 10.0, color: Colors.grey[500]),
    bodyLarge: const TextStyle(fontSize: 16.0, color: Colors.white),
    bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.white),
    bodySmall: const TextStyle(fontSize: 12.0, color: Colors.white),
    labelLarge: const TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(fontSize: 12.0, color: Colors.grey[300]),
    labelSmall: TextStyle(fontSize: 10.0, color: Colors.grey[300]),
  ),

  // AppBar Theme
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey[900],
    elevation: 4,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    actionsIconTheme: const IconThemeData(color: Colors.white),
  ),

  // Button Theme
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.tealAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.tealAccent,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),

  // Floating Action Button Theme
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.tealAccent,
    foregroundColor: Colors.black,
  ),

  // Icon Theme
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  // Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    hintStyle: TextStyle(fontSize: 12, color: Colors.grey[300]),
    fillColor: Colors.grey[800],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.tealAccent),
    ),
  ),

  // Divider Theme
  dividerTheme: DividerThemeData(
    color: Colors.grey[700],
    thickness: 1,
  ),

  // Card Theme
  cardTheme: CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    color: Colors.grey[850],
  ),

  // Chip Theme
  chipTheme: ChipThemeData(
    backgroundColor: Colors.grey[700],
    disabledColor: Colors.grey[600],
    selectedColor: Colors.tealAccent,
    secondarySelectedColor: Colors.tealAccent[400],
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    labelStyle: const TextStyle(color: Colors.white),
    secondaryLabelStyle: const TextStyle(color: Colors.black),
    brightness: Brightness.dark,
  ),

  // Tab Bar Theme
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.tealAccent,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 16),
  ),

  // Bottom Navigation Bar Theme
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.tealAccent,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontSize: 12),
  ),
);
