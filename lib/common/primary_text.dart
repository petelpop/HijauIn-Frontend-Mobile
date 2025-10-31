import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryText extends StatelessWidget {
  String? text;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  double? letterSpacing;
  double? lineHeight;
  TextAlign? textAlign;
  TextOverflow? textOverflow;
  int? maxLines;

  PrimaryText(
      {super.key,
      required this.text,
      this.fontSize = 14,
      this.color = const Color(0xFF2D746A),
      this.fontWeight = FontWeight.w400,
      this.textAlign = null,
      this.letterSpacing = 0,
      this.lineHeight = 0,
      this.textOverflow = null,
      this.maxLines = null});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: GoogleFonts.plusJakartaSans(
          fontWeight: fontWeight,
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          height: lineHeight),
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
