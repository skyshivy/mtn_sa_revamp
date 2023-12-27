import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_files/snack_bar/snack_bar.dart';
import 'package:mtn_sa_revamp/files/model/delete_wishlist_model.dart';
import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/model/wishlist_model.dart';
import 'package:mtn_sa_revamp/files/service_call/service_call.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:mtn_sa_revamp/files/utility/urls.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/view_model/delete_from_wishlist_vm.dart';

class WishlistController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<TuneInfo> list = <TuneInfo>[].obs;
  bool loadingData = false;
  getWishlist() async {
    if (loadingData) {
      return;
    }
    delay();
    loadingData = true;

    isLoading.value = true;
    var myPost = {
      "msisdn": StoreManager().msisdn,
      "language": StoreManager().language,
      "identifier": "ViewWishListItems",
      "wishlistType": "1"
    };
    var parts = [];

    myPost.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });

    var formData = parts.join('&');
    printCustom("\nformed data is \n$formData\n");
    Map<String, dynamic>? map =
        await ServiceCall().post(myWishListUrl, formData);
    if (map != null) {
      WishlistModel model = WishlistModel.fromJson(map);
      list.value = model.responseMap?.toneDetailsList ?? [];
    }
    StoreManager().isLoadWishlist = false;
    isLoading.value = false;
    printCustom(" ==== wishlist $map");
  }

  Future<void> delay() async {
    await Future.delayed(const Duration(milliseconds: 600));
    loadingData = false;
    return;
  }

  deleteFromWishlistAction(TuneInfo info, int index) async {
    DeleteWishlistModel model =
        await DeleteFromWishlistVM().delete(info.id ?? '');
    if (model.statusCode == 'SC0000') {
      showSnackBar(
          message: model.responseMap?.descriptiion ??
              model.message ??
              someThingWentWrongStr.tr);
      list.removeAt(index);
    } else {
      showSnackBar(message: model.message ?? '');
    }
  }
}
