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
    // highlightColor: Colors.lightBlue[200],
    );
