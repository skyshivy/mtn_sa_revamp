import 'package:get/get.dart';

class DayModel {
  String title;
  RxBool? isSelected = false.obs;
  DayModel(
    this.title,
  );
}
