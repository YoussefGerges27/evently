import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.lightBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 5,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.primaryColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 22,
          color: ColorsManager.primaryColor),
      iconTheme: IconThemeData(
        color: ColorsManager.primaryColor,
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blackColor,
      ),
      titleMedium: TextStyle(
        color: Color(0xff7B7B7B),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorsManager.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: ColorsManager.primaryColor,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: ColorsManager.primaryColor,
      background: ColorsManager.lightBackgroundColor,
      secondary: ColorsManager.blackColor,
      tertiary: Color(0xff7B7B7B),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBackgroundColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: Colors.white,
          width: 5,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.darkBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 22,
            color: ColorsManager.primaryColor),
        iconTheme: IconThemeData(color: ColorsManager.primaryColor)),
    colorScheme: const ColorScheme.dark(
      primary: ColorsManager.primaryColor,
      background: ColorsManager.darkBackgroundColor,
      secondary: ColorsManager.darkTextColor,
      tertiary: Color(0xffF4EBDC),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: ColorsManager.darkTextColor,
      ),
      titleMedium: TextStyle(
        color: Color(0xffF4EBDC),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: ColorsManager.primaryColor,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.primaryColor,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: ColorsManager.primaryColor,
      ),
    ),
  );
}
