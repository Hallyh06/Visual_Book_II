import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarNotification {
  static void showSuccessMessage(
    BuildContext context, {
    String? title,
    required String message,
  }) {
    Flushbar(
      title: title ?? 'Success',
      titleColor: const Color(0xffFFFFFF),
      message: message,
      titleSize: 18,
      messageSize: 12,
      backgroundColor: const Color(0xff000000),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.bounceIn,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

  static void showErrorMessage(
    BuildContext context, {
    String? title,
    required String message,
  }) {
    Flushbar(
      title: title ?? 'Error!!',
      message: message,
      titleSize: 18,
      titleColor: Colors.red,
      messageSize: 12,
      backgroundColor: const Color(0xff000000),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.bounceIn,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
