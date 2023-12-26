import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/home_controllers/home_status_tone_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class HomeStatusToneScreen extends StatefulWidget {
  const HomeStatusToneScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeStatusToneScreen();
}

class _HomeStatusToneScreen extends State<HomeStatusToneScreen> {
  late HomeStatusToneController statusCont;
  @override
  void initState() {
    statusCont = Get.find();
    makeApiCall();
    super.initState();
  }

  makeApiCall() async {
    await Future.delayed(const Duration(milliseconds: 300));
    statusCont.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: red,
      child: Obx(() {
        return CustomText(title: "Items length ${statusCont.tuneList.length}");
      }),
    );
  }
}
