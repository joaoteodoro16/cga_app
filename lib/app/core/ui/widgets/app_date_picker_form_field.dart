import 'package:cga_app/app/core/ui/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class AppDatePickerFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final FormFieldValidator<String>? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Locale locale;
  final ValueChanged<DateTime>? onDateSelected;

  const AppDatePickerFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.locale = const Locale('pt', 'BR'),
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      label: label,
      controller: controller,
      isRequired: isRequired,
      validator: validator,
      readOnly: true,
      onTap: () async {
        FocusScope.of(context).unfocus();
        final first = firstDate ?? DateTime(1900);
        final last = lastDate ?? DateTime(2100);

        final now = DateTime.now();
        final parsedDate = _parseDate(controller.text);
        final initialDate = _normalizeInitialDate(parsedDate ?? now, first, last);

        final selectedDate = await showDatePicker(
          context: context,
          locale: locale,
          initialDate: initialDate,
          firstDate: first,
          lastDate: last,
        );

        if (selectedDate == null) {
          return;
        }

        controller.text = _formatDate(selectedDate);
        onDateSelected?.call(selectedDate);
      },
    );
  }

  DateTime _normalizeInitialDate(DateTime date, DateTime first, DateTime last) {
    if (date.isBefore(first)) {
      return first;
    }
    if (date.isAfter(last)) {
      return last;
    }
    return date;
  }

  DateTime? _parseDate(String value) {
    final parts = value.split('/');
    if (parts.length != 3) {
      return null;
    }

    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);

    if (day == null || month == null || year == null) {
      return null;
    }

    final date = DateTime(year, month, day);
    if (date.day != day || date.month != month || date.year != year) {
      return null;
    }

    return date;
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
