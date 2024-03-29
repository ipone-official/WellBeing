import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Sukhumvit",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // colorSchemeSeed:  Color.fromRGBO(248, 200, 73, 1),
    colorSchemeSeed:  Color.fromRGBO(0,127,196,100),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.grey),
    gapPadding: 0,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: Colors.indigo),
    bodyText2: TextStyle(color: Colors.indigo),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Color.fromRGBO(248, 200, 73, 1),
    // color: Color.fromRGBO(0,127,196,100),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black), systemOverlayStyle: SystemUiOverlayStyle.dark, 
  );
}
