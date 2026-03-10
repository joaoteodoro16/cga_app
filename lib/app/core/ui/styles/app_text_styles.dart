import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static AppTextStyles? _instance;

  AppTextStyles._();
  static AppTextStyles get instance => _instance ??= AppTextStyles._();

  static String get font => 'Inter';

  TextStyle get _default => TextStyle(fontFamily: font, color: AppColors.primaryText);

  TextStyle get textLight =>
      _default.copyWith(fontWeight: FontWeight.w300);

  TextStyle get textRegular =>
      _default.copyWith(fontWeight: FontWeight.normal);

  TextStyle get textMedium =>
      _default.copyWith(fontWeight: FontWeight.w500);

  TextStyle get textSemiBold =>
      _default.copyWith(fontWeight: FontWeight.w600);

  TextStyle get textBold =>
      _default.copyWith(fontWeight: FontWeight.bold, );

  TextStyle get textExtraBold =>
      _default.copyWith(fontWeight: FontWeight.w800);

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
