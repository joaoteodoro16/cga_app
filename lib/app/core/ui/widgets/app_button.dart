import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  primaryOutline,
  secondary,
  secondaryOutline,
}

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final AppButtonType type;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.width = double.infinity,
    this.height = 40,
    this.type = AppButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final style = _resolveStyle(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(
          title,
          style: context.textStyles.textMedium.copyWith(
            fontSize: 16,
            color: _resolveTextColor(),
          ),
        ),
      ),
    );
  }

  ButtonStyle _resolveStyle(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
        );

      case AppButtonType.primaryOutline:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          side: BorderSide(color: AppColors.primary),
        );

      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          elevation: 0,
        );

      case AppButtonType.secondaryOutline:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          side: BorderSide(color: AppColors.secondary),
        );
    }
  }

  Color _resolveTextColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppColors.white;

      case AppButtonType.primaryOutline:
        return AppColors.primary;

      case AppButtonType.secondary:
        return AppColors.white;

      case AppButtonType.secondaryOutline:
        return AppColors.secondary;
    }
  }
}