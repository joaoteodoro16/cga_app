import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class SelectEntityWidget extends StatelessWidget {
  final String label;
  final String? value;
  final Future<void> Function() onTap;
  final IconData? icon;

  const SelectEntityWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.borderColor;

    return Column(
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
        InkWell(
          onTap: () async => await onTap() ,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    value ?? 'Selecionar',
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 14,
                      color: value == null ? AppColors.labelText : AppColors.black,
                    ),
                  ),
                ),
                const Icon(Icons.search, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
