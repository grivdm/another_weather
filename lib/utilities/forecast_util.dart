import 'package:intl/intl.dart';

class ForecastUtil {
  static getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, MMM, d, y').format(dateTime);
  }
}
