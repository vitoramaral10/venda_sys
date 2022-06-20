import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import './light_colors.dart';

ThemeData get lightTheme {
  var theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: appBgColor,
  );

  // Main settings
  theme = theme.copyWith(
    colorScheme: theme.colorScheme.copyWith(
      onSecondary: btnPrimaryTxtColor,
      secondary: btnPrimaryBgColor,
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      bodyText2: GoogleFonts.ibmPlexSans(
        color: appTxtColor,
        fontSize: 14,
      ),
      headline1: GoogleFonts.ibmPlexSans(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      headline2: GoogleFonts.ibmPlexSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      headline3: GoogleFonts.ibmPlexSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      headline4: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      headline5: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      headline6: GoogleFonts.ibmPlexSans(
        fontSize: 22,
        color: appTxtColor,
      ),
      subtitle1: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      subtitle2: GoogleFonts.ibmPlexSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: appTxtColor,
      ),
      button: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // AppBar settings
  theme = theme.copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: appbarBgColor,
      elevation: 0,
      foregroundColor: appbarTxtColor,
    ),
  );

  // PrimaryButton settings
  final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    primary: appLinkTxtColor,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // SecondaryButton settings
  final ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // LinkButton settings
  final ButtonStyle textButtonStyle = TextButton.styleFrom(
    primary: appTxtColor,
  );

  // Buttons settings
  theme = theme.copyWith(
    appBarTheme: const AppBarTheme(
      color: appLinkTxtColor,
      elevation: 1,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    primaryColor: appLinkTxtColor,
    drawerTheme: const DrawerThemeData(
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: secondaryButtonStyle),
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    textSelectionTheme: const TextSelectionThemeData(cursorColor: appLinkTxtColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: appTxtColor),
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

  return theme;
}
