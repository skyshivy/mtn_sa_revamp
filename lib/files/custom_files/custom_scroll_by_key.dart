import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtn_sa_revamp/main.dart';

Widget customScroll(Widget widget, ScrollController controller) {
  void handleKeyEvent(RawKeyEvent event) {
    var offset = controller.offset;
    print("Key is pressiing");
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (offset <= 0) {
        return;
      }
      if (kReleaseMode) {
        controller.animateTo(offset - 120,
            duration: const Duration(milliseconds: 80), curve: Curves.ease);
      } else {
        controller.animateTo(offset - 120,
            duration: const Duration(milliseconds: 80), curve: Curves.ease);
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        return;
      }

      if (kReleaseMode) {
        controller.animateTo(offset + 120,
            duration: const Duration(milliseconds: 80), curve: Curves.ease);
      } else {
        controller.animateTo(offset + 120,
            duration: const Duration(milliseconds: 80), curve: Curves.ease);
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
