import 'package:intl/intl.dart';

class DateService {
  static String getDateString(DateTime date) {
    // we have 3 states
    // 1- yesterday =======> 04:15 am yesterday
    // 1- today ===========> 04:15 am
    // 3- before yesterday=> 04:15 am 2022-01-17

    DateTime now = DateTime.now();
    int n = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    String finalDate;
    switch (n) {
      case -1:
        {
          final yesterday = 'امس';
          finalDate = yesterday + '  ' + DateFormat('hh:mm a').format(date).replaceAll('AM', 'ص').replaceAll('PM', 'م');
          break;
        }
      case 0:
        {
          finalDate = DateFormat('hh:mm a').format(date).replaceAll('AM', 'ص').replaceAll('PM', 'م');;
          break;
        }
      default:
        {
          var formatter = new DateFormat('dd-MM-yyyy');
          String dateFormat = formatter.format(date);
          String timeFormat = DateFormat('hh:mm a').format(date).replaceAll('AM', 'ص').replaceAll('PM', 'م');
          finalDate = dateFormat + '، ' + timeFormat;
          break;
        }
    }
    return finalDate;
  }
}
