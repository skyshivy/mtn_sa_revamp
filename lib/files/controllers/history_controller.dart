import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/model/history_model.dart';
import 'package:mtn_sa_revamp/files/view_model/get_history_vm.dart';

class HistoryController extends GetxController {
  RxList<TransactionDetailsList> transactions = <TransactionDetailsList>[].obs;
  RxBool isLoading = false.obs;
  RxString message = "".obs;

  @override
  void onInit() {
    getHistory();
    super.onInit();
  }

  getHistory() async {
    isLoading.value = true;
    HistoryModel historyModel = await getHistoryApi();
    transactions.value = historyModel.responseMap?.transactionDetailsList ?? [];
    isLoading.value = false;
  }
}
