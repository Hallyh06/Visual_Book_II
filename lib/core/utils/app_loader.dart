import 'package:flutter/material.dart';

class AppLoadingPopUp {
  Future<dynamic> show(
    BuildContext context, {
    String? text,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              color: const Color(0xffDBD2C2),
              strokeWidth: 5,
              backgroundColor: const Color(0xffDBD2C2).withOpacity(0.8),
            ),
          ),
        );
      },
    );
  }
}
