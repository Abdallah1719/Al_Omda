import 'package:al_omda/core/utils/index.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: R.colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: R.colors.white,
      iconTheme: IconThemeData(color: R.colors.darkgreen),
    ),
    //main colors
    textTheme: TextTheme(
      titleLarge: TextStyle(fontSize: R.fontSize.s20),
      titleMedium: TextStyle(
        fontSize: R.fontSize.s18,
        color: R.colors.darkgrey,
      ),
      titleSmall: TextStyle(fontSize: R.fontSize.s16),
      headlineLarge: TextStyle(
        fontSize: R.fontSize.s24,
        fontWeight: FontWeight.w600,
        color: R.colors.darkgreen,
      ),
      headlineMedium: TextStyle(
        fontSize: R.fontSize.s22,
        color: R.colors.grey,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: R.fontSize.s18,
        color: R.colors.darkgrey,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        fontSize: R.fontSize.s16,
        color: R.colors.darkgrey,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontSize: R.fontSize.s14,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(fontSize: R.fontSize.s12),
    ),

    // input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(R.padding.p8),
      hintStyle: TextStyle(color: R.colors.darkgreen, fontSize: R.fontSize.s14),

      // errorStyle: TextStyle(color: R.colors.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: R.colors.lightgreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: R.colors.lightgreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: R.colors.darkgreen,
      selectionHandleColor: Colors.blue,
      selectionColor: Colors.green,
    ),
    // Button Theme
    buttonTheme: ButtonThemeData(
      buttonColor: R.colors.primaryColor,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: R.colors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(double.infinity, 60),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Poppins',

    // input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(R.padding.p8),
      hintStyle: TextStyle(color: R.colors.darkgreen, fontSize: R.fontSize.s14),
      // errorStyle: TextStyle(color: R.colors.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: R.colors.lightgreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: R.colors.lightgreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: R.colors.lightgreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.red,
      selectionHandleColor: Colors.blue,
      selectionColor: Colors.green,
    ),
  );

  //   primary: Colors.blue,
  //   secondary: Colors.tealAccent,
  //   surface: Colors.grey,
  //   onPrimary: Colors.black,
  //   onSecondary: Colors.black,
  //   onSurface: Colors.white,
}
