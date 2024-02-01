import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/app_setting_model.dart';
import 'package:mtn_sa_revamp/files/model/custom_validity_model.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

Future<String> customTuneChanrge(String packName, String charge) async {
  List<CustomValidtyModel> validityModel = [];
  Others? others = StoreManager().appSetting?.responseMap?.settings?.others;
  String attributes = StoreManager().isEnglish
      ? (others?.validityEnglish?.attribute ?? '')
      : (others?.validityBurmese?.attribute ?? '');
  List<String> listOfValidity = attributes.split('|');
  printCustom("listOfValidity =====${listOfValidity}");
  for (var item in listOfValidity) {
    CustomValidtyModel mode =
        CustomValidtyModel(item.split(',')[0], item.split(',')[1]);
    validityModel.add(mode);
  }
  await Future.delayed(Duration(milliseconds: 100));
  printCustom("validityModel===== ${validityModel}");
  String customPrice = '';
  var price = validityModel.map((e) {
    printCustom("item = $e");
    if (e.packName == packName) {
      String price = e.units.replaceAll("price", charge);
      customPrice = price;
      return customPrice;
    }
  });
  printCustom("Tune chrage $price == customPrice = $customPrice");

  return customPrice;
}
