import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TuneCellController extends GetxController {
  late SizingInformation si;
  bool isWishlist = false;
  RxBool isSelected = false.obs;
  RxList<TuneInfo> tuneList = <TuneInfo>[].obs;
}
