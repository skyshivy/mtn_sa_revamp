import 'package:flutter/widgets.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

TextStyle calenderDateStyle() {
  return TextStyle(fontFamily: FontName.abook.name);
}

TextStyle calenderWeekDayStyle() {
  return TextStyle(fontFamily: FontName.abook.name, color: lightGreen);
}

TextStyle calenderYearStyle() {
  return TextStyle(fontFamily: FontName.abook.name, color: black);
}
