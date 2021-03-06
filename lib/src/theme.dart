import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomTheme {
  static ThemeData theme() {
    return ThemeData(
      // primarySwatch: Colors.pink, //
      // backgroundColor: Colors.pink, //
      // accentColor: Colors.deepPurple, //
      // accentColorBrightness: Brightness.dark, //
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Muli",
      appBarTheme: appBarTheme(),
      textTheme: textTheme(),
      inputDecorationTheme: inputDecorationTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: Constants.kTextColor),
      gapPadding: 0,
    );
    return InputDecorationTheme(
      // If  you are using latest version of flutter then lable text and hint text shown like this
      // if you r using flutter less then 1.20.* then maybe this is not working properly
      // if we are define our floatingLabelBehavior in our theme then it's not applayed
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }

  static TextTheme textTheme() {
    return TextTheme(
      bodyText1: TextStyle(color: Constants.kTextColor),
      bodyText2: TextStyle(color: Constants.kTextColor),
    );
  }

  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
        headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
      ),
    );
  }
}
