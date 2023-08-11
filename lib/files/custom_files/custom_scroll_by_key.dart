import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customScroll(Widget widget, ScrollController controller) {
  final FocusNode focusNode = FocusNode();
  void handleKeyEvent(RawKeyEvent event) {
    var offset = controller.offset;

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
    focusNode: focusNode,
    autofocus: true,
    onKey: handleKeyEvent,
    child: widget,
  );
}
