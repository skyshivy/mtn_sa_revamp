import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mtn_sa_revamp/files/controllers/delete_controller.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_buttons/custom_button.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

class DeleteScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  late DeleteController deCont;
  @override
  void initState() {
    deCont = Get.put(DeleteController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DeleteController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGreen,
      child: Column(
        children: [
          SizedBox(height: 80),
          Obx(() {
            return AnimatedContainer(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  deCont.isAnimating.value ? 125 : 20,
                ),
                color: deCont.isAnimating.value ? red : white,
              ),
              duration: Duration(milliseconds: 200),
              height: 250,
              width: 250,
            );
          }),
          SizedBox(height: 30),
          CustomButton(
            width: 200,
            color: white,
            textColor: black,
            title: "Rotate",
            onTap: () {
              print("object");
              deCont.startAnimation();
            },
          )
        ],
      ),
    );
  }
}
