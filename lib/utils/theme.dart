import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
figmaFontsize(int fontSize) {
  return fontSize * 0.80;
}
const Color primaryTextColor = Colors.white;
Color secondaryColor = Colors.black;

TextStyle ImagespecialText = GoogleFonts.inter(
    textStyle: TextStyle(
        color: primaryTextColor,
        fontWeight: FontWeight.w700,
        fontSize: figmaFontsize(16)));
TextStyle Normaltext = GoogleFonts.inter(
    textStyle: TextStyle(
        color: secondaryColor,
        fontWeight: FontWeight.w500,
        fontSize: figmaFontsize(18)));
TextStyle HeadingText = GoogleFonts.inter(
  textStyle:TextStyle(
    color: secondaryColor,
    fontWeight: FontWeight.w700,
    fontSize: figmaFontsize(24)
  )
);
