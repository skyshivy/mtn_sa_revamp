import 'package:intl/intl.dart';

class GetDate {
  today({String inFormate = 'dd-MM-yyyy'}) {
    final DateTime now = DateTime.now();

    final DateFormat formatter = DateFormat(inFormate);
    final String formatted = formatter.format(now);
    return formatted;
  }

  convertFromDate(DateTime? date, {String inFormate = "yyyy-MM-dd HH: MI:SS"}) {
    if (date != null) {
      return "";
    }
    final DateFormat formatter = DateFormat(inFormate);
    final String formatted = formatter.format(date!);
    return formatted;
  }

  customDate(
      {String inFormate = 'dd-MM-yyyy',
      required bool isBackMonth,
      required int month}) {
    final DateTime now = DateTime.now();
    final customDate = DateTime(
        now.year, isBackMonth ? now.month - month : now.month + month, now.day);
    final DateFormat formatter = DateFormat(inFormate);
    final String formatted = formatter.format(customDate);
    return formatted;
  }
}
