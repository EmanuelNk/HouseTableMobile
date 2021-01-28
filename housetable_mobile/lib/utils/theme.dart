import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeColors {
  static const PRIMATY_COLOR = const Color(0xFF474747);
  static const PRIMATY_2 = const Color(0xFF666666);
  static const ACCENT_COLOR = const Color(0xFFC7772D);
  static const ACCENT_BRIGHTER = const Color(0xFFCA905A);
  static const DARK_COLOR = const Color(0xFF313131);
  static const INACTIVE_ACCENT = const Color(0xFFB69679);
  static const TEXT_COLOR_DARK = const Color(0xFF202020);
  static const TEXT_COLOR_Light = const Color(0xFFffffff);
  static const ERROR_COLOR = const Color(0xFFE53935);
  static const SUCCESS_COLOR = const Color(0xFF7CB342);
  static const BACKGROUND_COLOR = const Color(0xFF3B3B3B);
  // static const PRIMARY3 = const Color(0xFF30475e);
  // static const PRIMARY2 = const Color(0xFF273A4D);
  static const FOREGROUND_COLOR = const Color(0xFF474747);
  static const DISABLED_COLOR = const Color(0xFFD2D2D2);
}

class ThemeUtil {
  getTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: ThemeColors.PRIMATY_COLOR,
      accentColor: ThemeColors.ACCENT_COLOR,
      cursorColor: ThemeColors.TEXT_COLOR_DARK,
      backgroundColor: ThemeColors.BACKGROUND_COLOR,
      canvasColor: ThemeColors.BACKGROUND_COLOR,
      splashColor: ThemeColors.ACCENT_COLOR.withOpacity(0.2),
      highlightColor: ThemeColors.ACCENT_COLOR.withOpacity(0.1),
      disabledColor: ThemeColors.DISABLED_COLOR,
      textSelectionHandleColor: ThemeColors.PRIMATY_COLOR,
      textSelectionColor: ThemeColors.PRIMATY_COLOR.withOpacity(0.4),
      textTheme: GoogleFonts.exoTextTheme(),
    );
  }
}

ThemeUtil themeUtil = new ThemeUtil();
