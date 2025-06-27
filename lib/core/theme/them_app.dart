import 'package:flutter/material.dart';
import '../resources/color_manger.dart';
import '../resources/font_manger.dart';

final appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  colorScheme: ColorScheme.light(
    primary: AppColorManger.primaryColor,
  ),
  //? dialogBackgroundColor: AppColorManger.white,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s24,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s20,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s16,
    ),
    titleSmall: TextStyle(
      fontFamily: AppFontFamily.book,
      fontSize: AppFontSizeManger.s24,
    ),
    labelSmall: TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s14,
    ),
  ),
  );
