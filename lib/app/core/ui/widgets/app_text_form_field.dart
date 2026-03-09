import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final double width;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final bool obscureText;
  final bool enabled;

  const AppTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.width = double.infinity,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
    this.obscureText = false, 
     this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.borderColor;
    final focusColor = AppColors.primary;
    final errorBorderColor = AppColors.error;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textStyles.textRegular.copyWith(
              fontSize: 14,
              color: AppColors.labelText,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            enabled: enabled,
            obscureText: obscureText,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.primary)
                  : null,
              fillColor: AppColors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: focusColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: errorBorderColor, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: errorBorderColor, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
            ),
            inputFormatters: inputFormatters,
            style: context.textStyles.textRegular.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
