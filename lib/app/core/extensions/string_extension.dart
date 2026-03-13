import 'package:cga_app/app/core/exceptions/exceptions.dart';

extension StringExtension on String {
  String? get nullIfEmpty {
    final text = trim();
    return text.isEmpty ? null : text;
  }

  double get toDoubleOrThrow {
    final text = trim();

    if (text.isEmpty) {
      throw AppException(message: 'Valor numérico inválido');
    }

    final normalized = text.contains(',') && text.contains('.')
        ? text.replaceAll('.', '').replaceAll(',', '.')
        : text.replaceAll(',', '.');

    final parsed = double.tryParse(normalized);

    if (parsed == null) {
      throw AppException(message: 'Valor numérico inválido: $text');
    }

    return parsed;
  }

}
