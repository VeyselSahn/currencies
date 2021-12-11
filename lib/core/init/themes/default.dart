import 'package:flutter/material.dart';

ThemeData defaultTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Color.fromRGBO(11, 125, 167, 1),
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.white)),
    disabledColor: Colors.grey,
    cardColor: Colors.black,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    //tabBarTheme: TabBarTheme(indicator: Decoration.lerp(223, 223, 150)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green))),
    indicatorColor: Colors.white,
    primaryColor: Color.fromRGBO(11, 125, 167, 1),
    iconTheme: IconThemeData(color: Colors.green, size: 27),
    canvasColor: Colors.black,
    cardTheme: CardTheme(color: Color.fromRGBO(11, 125, 167, 1)),
    radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(Colors.grey)),
    textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white),
        headline5: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.grey),
        subtitle1: TextStyle(color: Colors.white, fontSize: 16)),
    dividerColor: Color.fromRGBO(11, 125, 167, 1));
