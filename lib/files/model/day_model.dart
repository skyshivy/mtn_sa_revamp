import 'package:get/get.dart';

class DayModel {
  String title;
  RxBool? isSelected = true.obs;
  DayModel(
    this.title,
  );
}
