import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/model/day_model.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class TuneSettingController extends GetxController {
  RxInt callerType = 0.obs;

  String tuneName = '';
  String tuneId = '';
  String tuneImage = '';
  String tuneArtist = '';

  List<DayModel> daysList = [
    DayModel(sunStr),
    DayModel(monStr),
    DayModel(tueStr),
    DayModel(wedStr),
    DayModel(thusStr),
    DayModel(friStr),
    DayModel(satStr),
  ];
}
