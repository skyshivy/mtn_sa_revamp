import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/custom_files/loading_indicator.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget loadMoreDataButton({
  bool enableLeftButton = false,
  bool enableRightButton = true,
  bool isLoading = false,
  Function()? leftAction,
  Function()? rightAction,
}) {
  return SizedBox(
    height: 50,
    child: isLoading
        ? _loadingIndi()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftButton(enableLeftButton,
                  leftAction), //(enableLeftButton, leftAction),
              rightButton(enableRightButton, rightAction)
            ],
          ),
  );
}

SingleChildRenderObjectWidget rightButton(
    bool enableRightButton, Function()? rightAction) {
  return enableRightButton
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            onPressed: () {
              rightAction!();
              printCustom("arrow_forward_ios tapped");
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        )
      : const SizedBox();
}

SingleChildRenderObjectWidget leftButton(
    bool enableLeftButton, Function()? leftAction) {
  return enableLeftButton
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            onPressed: () {
              printCustom("arrow_back_ios tapped");
              leftAction!();
              //leftAction != null?()
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        )
      : const SizedBox();
}

Row _loadingIndi() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [loadingIndicator(radius: 12)],
  );
}
