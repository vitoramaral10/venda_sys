import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:venda_sys/config/constants.dart';

class CustomThemeData {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Constants.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Constants.primaryColor,
      foregroundColor: Colors.white,
    ),
    primaryColorLight: Constants.primaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Constants.primaryColor,
      secondary: Constants.primaryColor,
      surface: Constants.primaryColor,
      onSurface: Constants.textColor,
      onPrimary: Constants.textColor,
    ),
    iconTheme: const IconThemeData(
      size: 20,
      color: Constants.textColor,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(Constants.textColor),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Constants.primaryColor;
          }

          return null;
        },
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Constants.primaryColor;
          }

          return null;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Constants.primaryColor.withOpacity(0.6);
          }

          return null;
        },
      ),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Constants.textColor,
      labelColor: Constants.primaryColor,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Constants.primaryColor, width: 2),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      bodyText2: GoogleFonts.ibmPlexSans(
        color: Constants.textColor,
        fontSize: 14,
      ),
      headline1: GoogleFonts.ibmPlexSans(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline2: GoogleFonts.ibmPlexSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline3: GoogleFonts.ibmPlexSans(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline4: GoogleFonts.ibmPlexSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline5: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      headline6: GoogleFonts.ibmPlexSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      subtitle1: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      subtitle2: GoogleFonts.ibmPlexSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Constants.textColor,
      ),
      button: GoogleFonts.ibmPlexSans(
        fontSize: 14,
        color: Constants.textColor,
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
        onPrimary: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.radius),
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
          borderRadius: BorderRadius.circular(Constants.radius),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Constants.textColor,
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      iconColor: Constants.textColor,
      textColor: Constants.textColor,
      collapsedIconColor: Constants.textColor,
      collapsedTextColor: Constants.textColor,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: Constants.textColor),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: Constants.textColor),
      fillColor: Colors.orange,
      contentPadding: const EdgeInsets.all(Constants.defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.radius),
        borderSide: BorderSide(
          color: Colors.grey[400]!,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 13,
      ),
    ),
  );
}
