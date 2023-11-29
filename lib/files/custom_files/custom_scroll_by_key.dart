import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtn_sa_revamp/main.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';

Widget customScroll(ScrollController controller, Widget widget) {
  int inde = 0;
  void handleKeyEvent(RawKeyEvent event) {
    var offset = controller.offset;
    printCustom("Key is pressiing $event");
    // if (inde == 2) {
    //   inde = 0;
    // } else {
    //   inde += 1;
    //   return;
    // }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (offset <= 0) {
        return;
      }
      if (kReleaseMode) {
        controller.animateTo(offset - 120,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      } else {
        controller.animateTo(offset - 120,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        return;
      }

      if (kReleaseMode) {
        controller.animateTo(offset + 120,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      } else {
        controller.animateTo(offset + 120,
            duration: const Duration(milliseconds: 200), curve: Curves.ease);
      }
    }
  }

  return RawKeyboardListener(
    focusNode: keyScrollFocusNode,
    autofocus: true,
    onKey: handleKeyEvent,
    child: widget,
  );
}
