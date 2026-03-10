import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class SelectEntityWidget extends StatefulWidget {
  final String label;
  final String? value;
  final String? initialId; // padrão para qualquer entidade
  final Future<String?> Function(String id)? resolveValueById; // genérico
  final Future<void> Function() onTap;
  final IconData? icon;

  const SelectEntityWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.value,
    this.initialId,
    this.resolveValueById,
    this.icon,
  });

  @override
  State<SelectEntityWidget> createState() => _SelectEntityWidgetState();
}

class _SelectEntityWidgetState extends State<SelectEntityWidget> {
  String? _displayValue;

  @override
  void initState() {
    super.initState();
    _displayValue = widget.value;
    _tryResolveInitialId();
  }

  @override
  void didUpdateWidget(covariant SelectEntityWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _displayValue = widget.value;
    }

    if (widget.initialId != oldWidget.initialId && widget.value == null) {
      _tryResolveInitialId();
    }
  }

  Future<void> _tryResolveInitialId() async {
    final id = widget.initialId;
    if (id == null || id.isEmpty) return;
    if (widget.resolveValueById == null) return;
    if (widget.value != null) return;

    final resolved = await widget.resolveValueById!(id);
    if (!mounted) return;
    setState(() => _displayValue = resolved);
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.borderColor;
    final value = _displayValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: context.textStyles.textRegular.copyWith(
            fontSize: 14,
            color: AppColors.labelText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () async => await widget.onTap(),
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
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: AppColors.primary, size: 20),
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
