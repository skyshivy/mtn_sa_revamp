import 'package:get/get.dart';

class DrawerModel {
  String title;
  RxBool? isSelected = false.obs;
  RxBool? isExpandable = false.obs;
  DrawerModel(this.title, {bool? isSelect, bool? isExpanded}) {
    isSelected?.value = isSelect ?? false;
    isExpandable?.value = isExpanded ?? false;
  }
}
