import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

//////////// colors

var primaryColor = HexColor("#Ffd23f");
var myDarkGreen = HexColor("#1e5631");
var myLightGreen = HexColor("#a4de02");
var DarkBackground = HexColor("#121212");

Color primaryColorLight = const Color.fromRGBO(255, 210, 63, 0.08);
Color myDarkGreenLight = const Color.fromRGBO(30, 86, 49, 0.1);
Color myLightGreenLight = const Color.fromRGBO(164, 222, 2, 0.1);

const MaterialColor primaryColorMaterial = const MaterialColor(
  0xffFfd23f,
  const <int, Color>{
    50: const Color(0xffFfd23f),
    100: const Color(0xffFfd23f),
    200: const Color(0xffFfd23f),
    300: const Color(0xffFfd23f),
    400: const Color(0xffFfd23f),
    500: const Color(0xffFfd23f),
    600: const Color(0xffFfd23f),
    700: const Color(0xffFfd23f),
    800: const Color(0xffFfd23f),
    900: const Color(0xffFfd23f),
  },
);
Color lightGrey = Color.fromRGBO(217, 217, 217, 0.2);

///////////// themes (in main)

dynamic lightMode = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  primaryColor: primaryColor,
  primarySwatch: primaryColorMaterial,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.dark,
    ),
    color: primaryColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15),
      ),
    ),
    toolbarHeight: 70,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: primaryColor,
    selectedLabelStyle: TextStyle(color: primaryColor),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.black, fontSize: 22, fontWeight: FontWeight.w300),
    bodyText2: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
  ),
);

dynamic darkMode = ThemeData(
  scaffoldBackgroundColor: DarkBackground,
  backgroundColor: DarkBackground,
  primaryColor: primaryColor,
  primarySwatch: primaryColorMaterial,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
    ),
    color: primaryColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(15),
      ),
    ),
    toolbarHeight: 70,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: primaryColor,
    selectedLabelStyle: TextStyle(color: primaryColor),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
    bodyText2: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
  ),
);
