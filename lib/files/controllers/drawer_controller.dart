import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/category_model.dart';
import 'package:mtn_sa_revamp/files/model/drawer_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';

class MyDrawerController extends GetxController {
  RxList<DrawerModel> menuList = <DrawerModel>[].obs;
  RxList<AppCategory> catList = <AppCategory>[].obs;
  @override
  void onInit() {
    createMenuList();
    getPref();
    super.onInit();
  }

  createMenuList() {
    if (StoreManager().isLoggedIn) {
      menuList.value = [
        DrawerModel(profileStr),
        DrawerModel(myTuneStr),
        DrawerModel(wishlistStr),
        DrawerModel(tunesStr, isExpanded: true),
        DrawerModel(historyStr),
        //DrawerModel(faqStr),
        DrawerModel(logoutStr),
      ];
    } else {
      menuList.value = [
        DrawerModel(tunesStr, isExpanded: true),
        DrawerModel(signinStr),
        //DrawerModel(faqStr),
      ];
    }
  }

  getPref() async {
    var result = await ServiceCall().get(categoryListUrl);

    if (result != null) {
      CategoryModel model = CategoryModel.fromJson(result);
      catList.value = model.responseMap?.categories ?? [];
    }
  }
}
