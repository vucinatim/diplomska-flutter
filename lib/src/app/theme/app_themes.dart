import 'package:flutter/material.dart';

final Map<String, ThemeData> appThemes = <String, ThemeData>{
  'lightTheme': lightTheme,
  'darkTheme': darkTheme,
  'defaultTheme': defaultTheme,
};

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xffFF8580),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xffFF8580),
);

ThemeData defaultTheme = ThemeData.light().copyWith(
  highlightColor: const Color(0xfffff0f0),
  primaryColor: const Color(0xffff5666),
  accentColor: const Color(0xffff6295),
  colorScheme: const ColorScheme.light(
    primary: Color(0xffFF566A),
    onSecondary: Colors.white,
    secondary: Color(0xffffdadb),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(color: Color(0xff2A2B2A)),
  ).apply(
    bodyColor: const Color(0xff2A2B2A),
    displayColor: const Color(0xff2A2B2A),
  ),
);

ThemeData skyBlueTheme = ThemeData.light().copyWith(
  highlightColor: const Color(0xffdff9ff),
  primaryColor: const Color(0xff1eabcb),
  accentColor: const Color(0xff80fbff),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff1eabcb),
    onSecondary: Colors.white,
    secondary: Color(0xffbfe5f3),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(color: Color(0xff393D3F)),
  ).apply(
    bodyColor: const Color(0xff393D3F),
    displayColor: const Color(0xff393D3F),
  ),
);

ThemeData greenTheme = ThemeData.light().copyWith(
  highlightColor: const Color(0xfff0fff2),
  primaryColor: const Color(0xff61d24e),
  accentColor: const Color(0xff6bd575),
  colorScheme: const ColorScheme.light(
    primary: Color(0xff61d24e),
    onSecondary: Colors.white,
    secondary: Color(0xff61d24e),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(color: Color(0xff2A2B2A)),
  ).apply(
    bodyColor: const Color(0xff2A2B2A),
    displayColor: const Color(0xff2A2B2A),
  ),
);

ThemeData softPinkTheme = ThemeData.light().copyWith(
  highlightColor: const Color(0xfffff0f0),
  primaryColor: const Color(0xffff7374),
  accentColor: const Color(0xfffd80b4),
  colorScheme: const ColorScheme.light(
    primary: Color(0xffff7374),
    onSecondary: Colors.white,
    secondary: Color(0xffff7374),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(color: Color(0xff2A2B2A)),
  ).apply(
    bodyColor: const Color(0xff2A2B2A),
    displayColor: const Color(0xff2A2B2A),
  ),
);

ThemeData originalTheme = ThemeData.light().copyWith(
  highlightColor: const Color(0xfffff0f0),
  primaryColor: const Color(0xffff5666),
  accentColor: const Color(0xffff377b),
  colorScheme: const ColorScheme.light(
    primary: Color(0xffFF566A),
    onSecondary: Colors.white,
    secondary: Color(0xffFF566A),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
    subtitle1: TextStyle(color: Color(0xff2A2B2A)),
  ).apply(
    bodyColor: const Color(0xff2A2B2A),
    displayColor: const Color(0xff2A2B2A),
  ),
);
