import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static AppTextStyles? _instance;

  AppTextStyles._();
  static AppTextStyles get instance => _instance ??= AppTextStyles._();

  static String get font => 'Inter';

  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: font);

  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: font);

  TextStyle get textMedium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: font);

  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: font);

  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: font);

  TextStyle get textExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: font);

  TextStyle get textButtonLabel => textBold.copyWith(
        fontSize: 14,
        color: AppColors.white,
      );
  TextStyle get textTittle => textExtraBold.copyWith(
        fontSize: 28,
      );
}

extension TextStylesExtensions on BuildContext {
  AppTextStyles get textStyles => AppTextStyles.instance;
}
