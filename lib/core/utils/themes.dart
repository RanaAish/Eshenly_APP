

import 'package:esh7enly/core/utils/colors.dart';
import 'package:flutter/material.dart';

ThemeData apptheme()
{
  return ThemeData(
    primaryColor: CustomColors.MainColor,
    brightness: Brightness.light,
    textTheme:  TextTheme(
      button: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'ReadexPro',
      ) ,
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'ReadexPro',
      ),
      bodySmall: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CustomColors.MainColor),
      bodyText1:  const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontFamily: 'ReadexPro',
        fontWeight: FontWeight.bold,
      ),
    )
  );
}