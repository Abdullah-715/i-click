import 'package:flutter/material.dart';
import 'color_manger.dart';

class FiledBorder {
  OutlineInputBorder colorInputBorder(double radius) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: AppColorManger.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(radius));
  }

  OutlineInputBorder normalInputBorder(double radius) {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(radius));
  }

  OutlineInputBorder erorInputBorder(double radius) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: AppColorManger.error),
        borderRadius: BorderRadius.circular(radius));
  }
}
