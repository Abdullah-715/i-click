import 'package:flutter/material.dart';
import '../resources/color_manger.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static void errorToast(String message) {
    toastification.dismissAll();
    toastification.show(
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.bottomCenter,
        type: ToastificationType.error,
        showProgressBar: false,
        style: ToastificationStyle.fillColored,
        description: Text(message));
  }

  static void doneToast(String message) {
    toastification.dismissAll();
    toastification.show(
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.bottomCenter,
        primaryColor: AppColorManger.primaryColor,
        showProgressBar: false,
        style: ToastificationStyle.fillColored,
        type: ToastificationType.success,
        description: Text(message));
  }

  static void additinalToast(String message) {
    toastification.dismissAll();
    toastification.show(
        primaryColor: AppColorManger.primaryColor,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topCenter,
        showProgressBar: false,
        style: ToastificationStyle.fillColored,
        description: Text(message));
  }
}
