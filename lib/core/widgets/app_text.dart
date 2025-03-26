import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const AppText(
    this.text, {
    super.key,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.itim(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
