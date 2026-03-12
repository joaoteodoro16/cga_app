
import 'package:intl/intl.dart';

class DateUtil {
  DateUtil._();

  static String dateTimeToPTBRDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', 'pt_BR').format(date);
  }

  static DateTime pTBRDateToDateTime(String date) {
    final parsed = DateFormat('dd/MM/yyyy', 'pt_BR').parseStrict(date);
    return DateTime(parsed.year, parsed.month, parsed.day);
  }
}