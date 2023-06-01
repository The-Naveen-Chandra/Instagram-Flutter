import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color.fromRGBO(0, 0, 0, 1),
    primary: Colors.white,
    secondary: Colors.grey.shade900,
    tertiary: Colors.white,
  ),
);


// const mobileBackgroundColor = Color.fromRGBO(0, 0, 0, 1);
// const webBackgroundColor = Color.fromRGBO(18, 18, 18, 1);
// const mobileSearchColor = Color.fromRGBO(38, 38, 38, 1);
// const blueColor = Color.fromRGBO(0, 149, 246, 1);
// const primaryColor = Colors.white;
// const secondaryColor = Colors.grey;