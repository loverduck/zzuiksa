import 'package:flutter/material.dart';
import 'constants.dart';

var myTheme = ThemeData(
  primarySwatch: Colors.orange,
  scaffoldBackgroundColor: Constants.main200,
  fontFamily: 'OwnglyphChongchong',
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 48.0,
      color: Constants.textColor,
    ),
    displayMedium: TextStyle(
      fontSize: 32.0,
      color: Constants.textColor,
    ),
    displaySmall: TextStyle(
      fontSize: 22.0,
      color: Constants.textColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'BMJua',
      fontSize: 28.0,
      color: Constants.textColor,
      ),
    bodySmall: TextStyle(
      fontFamily: 'BMJua',
      fontSize: 12.0,
      color: Constants.textColor,
    ),
  )
);