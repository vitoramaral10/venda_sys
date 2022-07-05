import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venda_sys/config/constants.dart';

class CustomThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Constants.backgroundColor,
    textTheme: TextTheme(
      bodyText1: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize16,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      bodyText2: GoogleFonts.ibmPlexSans(
        color: Constants.textColor,
        fontSize: Constants.fontSize14,
      ),
      headline1: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize24,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline2: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize20,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline3: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize18,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline4: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize16,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline5: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize14,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline6: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize22,
        color: Constants.textColor,
      ),
      subtitle1: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize14,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      subtitle2: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize12,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      button: GoogleFonts.ibmPlexSans(
        fontSize: Constants.fontSize14,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.primaryColor,
      foregroundColor: Constants.textColor,
      elevation: 1,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryColor: Constants.primaryColor,
    drawerTheme: const DrawerThemeData(
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Constants.primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Constants.textColor,
      ),
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Constants.textColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Constants.textColor),
      fillColor: Colors.orange,
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 13,
      ),
    ),
  );
}