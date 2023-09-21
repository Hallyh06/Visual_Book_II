import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visual_book/core/constant/font_type.dart';

class VBfontsBase extends StatelessWidget {
  const VBfontsBase(
    this.text, {
    this.style,
    this.textAlign = TextAlign.left,
    this.overflow = TextOverflow.visible,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);
  final String? text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    assert(text != null, 'test can not be null');
    return Text(
      text ?? '',
      style: const TextStyle(
        fontFamily: VsFont.sanSariff,
        fontSize: 15,
      ).merge(style),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class TextBody extends VBfontsBase {
  TextBody(
    String text, {
    Key? key,
    TextStyle? style,
    Color? color,
    double? fontSize,
    TextAlign textAlign = TextAlign.left,
    FontWeight fontWeight = FontWeight.w400,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 2,
    double? height,
  }) : super(
          text,
          key: key,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
                  fontSize: fontSize ?? 14,
                  fontWeight: fontWeight,
                  height: height,
                  color: color)
              .merge(style),
          textAlign: textAlign,
        );
}

class H1 extends VBfontsBase {
  H1(
    String text, {
    Key? key,
    Color? color,
    TextStyle? style,
    double? fontSize,
    FontWeight fontWeight = FontWeight.w900,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 3,
  }) : super(
          text,
          key: key,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize ?? 30,
            fontWeight: fontWeight,
          ).merge(style),
          textAlign: textAlign,
        );
}

class TextBold extends VBfontsBase {
  TextBold(
    String text, {
    Key? key,
    TextStyle? style,
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 2,
  }) : super(
          text,
          key: key,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ).merge(style),
          textAlign: textAlign,
        );
}

class TextSemiBold extends VBfontsBase {
  TextSemiBold(
    String text, {
    Key? key,
    TextStyle? style,
    double? fontSize,
    Color? color,
    FontWeight fontWeight = FontWeight.w500,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 2,
  }) : super(
          text,
          key: key,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize ?? 14,
            color: color,
            fontWeight: fontWeight,
          ).merge(style),
          textAlign: textAlign,
        );
}

class TextSmall extends VBfontsBase {
  TextSmall(
    String text, {
    double fontSize = 12,
    Key? key,
    TextStyle? style,
    Color? color,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.visible,
    int maxLines = 2,
    FontStyle? fontStyle,
    FontWeight fontWeight = FontWeight.w300,
  }) : super(
          text,
          key: key,
          overflow: overflow,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            fontStyle: fontStyle,
          ).merge(style),
          textAlign: textAlign,
        );
}
