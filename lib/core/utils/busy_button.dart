import 'package:flutter/material.dart';
import 'package:visual_book/core/utils/font.dart';

class BusyButton extends StatefulWidget {
  const BusyButton({
    super.key,
    required this.ttitle,
    required this.onTap,
    this.buttonColor = const Color(0xffDBD2C2),
    this.titleColor = const Color(0xff000000),
  });
  final String ttitle;
  final VoidCallback onTap;
  final Color buttonColor;
  final Color titleColor;
  @override
  State<BusyButton> createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.buttonColor,
        ),
        child: Center(
          child: TextBold(
            widget.ttitle,
            fontSize: 14,
            color: widget.titleColor,
          ),
        ),
      ),
    );
  }
}
