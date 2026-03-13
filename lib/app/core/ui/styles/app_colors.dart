import 'package:flutter/material.dart';

// ignore_for_file: no_direct_color_usage
class AppColors {
  AppColors._();

  //TEXTO
  static Color get primaryText => const Color.fromARGB(255, 17, 17, 17);

  //APLICAÇÃO
  static Color get primary => Color(0XFF002144);
  static Color get secondary => Color.fromARGB(255, 163, 84, 0);
  static Color get screenBackgroundColor => const Color(0xFFF5F6FA);

  //COMUNS
  static Color get white => Colors.white;
  static Color get lightGrey => const Color.fromARGB(255, 207, 207, 207);
  static Color get mediumGrey => const Color.fromARGB(255, 158, 158, 158);
  static Color get transparent => Colors.transparent;
  static Color get black => Colors.black;

  //WIDGETS
  static Color get borderColor => Colors.grey[400] ?? Colors.grey;
  static Color get labelText => Colors.grey[800] ?? Colors.grey;
  static Color get activeTileEntityColor =>
      const Color.fromARGB(255, 71, 143, 80);
  static Color get inactiveTileEntityColor =>
      const Color.fromARGB(255, 255, 67, 67);

  //MENSAGENS/
  static Color get error => const Color.fromARGB(255, 248, 37, 37);
  static Color get warning => const Color.fromARGB(255, 255, 194, 61);
  static Color get info => const Color.fromARGB(255, 20, 103, 158);
  static Color get success => const Color.fromARGB(255, 64, 160, 45);

  //SOMBRAS
  static Color get menuButtonShadow015 => Colors.black.withValues(alpha: 0.15);
  static Color get menuButtonShadow005 => Colors.black.withValues(alpha: 0.05);
}
