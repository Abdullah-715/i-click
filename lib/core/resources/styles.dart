import 'package:flutter/material.dart';
import 'font_manger.dart';

class Styles {
  //? Heading :
  static final heading = TextStyle(
    fontFamily: AppFontFamily.bold,
    fontSize: AppFontSizeManger.s24,
  );
  //? Titles :
  static final title1 = TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s20,
      height: 1.2,
      letterSpacing: 0);
  static final title2 = TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s16,
      height: 1.2,
      letterSpacing: -0.1);
  static final title3 = TextStyle(
    fontFamily: AppFontFamily.book,
    fontSize: AppFontSizeManger.s16,
    height: 1.2,
    letterSpacing: -0.1,
  );
  static final title4 = TextStyle(
    fontFamily: AppFontFamily.bold,
    fontSize: AppFontSizeManger.s14,
  );
  //? Body :
  static final body1 = TextStyle(
      fontFamily: AppFontFamily.book,
      fontSize: AppFontSizeManger.s18,
      height: 1.5,
      letterSpacing: 0.4);
  static final body3 = TextStyle(
      fontFamily: AppFontFamily.book,
      fontSize: AppFontSizeManger.s16,
      letterSpacing: -0.2,
      height: 1.5);
  static final body4 = TextStyle(
    fontFamily: AppFontFamily.book,
    fontSize: AppFontSizeManger.s14,
  );
  static final body5 = TextStyle(
    fontFamily: AppFontFamily.book,
    fontSize: AppFontSizeManger.s12,
  );
  static final bodySemibold = TextStyle(
      fontFamily: AppFontFamily.bold,
      fontSize: AppFontSizeManger.s16,
      letterSpacing: 0.6,
      height: 1.5);
  //? Caption :
  static final caption = TextStyle(
      fontFamily: AppFontFamily.book,
      fontSize: AppFontSizeManger.s14,
      letterSpacing: 2);
}
