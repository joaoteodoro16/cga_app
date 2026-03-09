import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppComboBox<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) itemLabel;
  final void Function(T? value)? onChanged;
  final T? initialValue;
  final String? hint;
  final bool enabled;

  const AppComboBox({
    super.key,
    required this.items,
    required this.itemLabel,
    this.onChanged,
    this.initialValue,
    this.hint,
    this.enabled = true,
  });

  @override
  State<AppComboBox<T>> createState() => _AppComboBoxState<T>();
}

class _AppComboBoxState<T> extends State<AppComboBox<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint ?? '',
          style: context.textStyles.textRegular.copyWith(
            fontSize: 14,
            color: AppColors.labelText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<T>(
          initialValue: _selected,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: !widget.enabled,
            fillColor: widget.enabled ? null : AppColors.lightGrey,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(widget.itemLabel(item)),
            );
          }).toList(),
          onChanged: widget.enabled
              ? (value) {
                  setState(() {
                    _selected = value;
                  });

                  widget.onChanged?.call(value);
                }
              : null,
        ),
      ],
    );
  }
}
