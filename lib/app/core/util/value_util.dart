import 'package:intl/intl.dart';

class ValueUtil {
	ValueUtil._();

	static String toPtBr(
		double value, {
		int decimalDigits = 2,
	}) {
		return NumberFormat.decimalPatternDigits(
			locale: 'pt_BR',
			decimalDigits: decimalDigits,
		).format(value);
	}
}
