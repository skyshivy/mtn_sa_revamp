library hover_menu;

import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

import 'hover_menu_controller.dart';

class HoverMenu extends StatefulWidget {
  final Widget title;
  final double? width;
  final Widget widget;
  final FocusNode focusNode;
  //final List<Widget> items;

  final HoverMenuController? controller;

  const HoverMenu({
    super.key,
    required this.title,
    this.width,
    this.controller,
    required this.widget,
    required this.focusNode,
  });

  @override
  HoverMenuState createState() => HoverMenuState();
}

class HoverMenuState extends State<HoverMenu> {
  OverlayEntry? _overlayEntry;
  //final _focusNode = FocusNode();
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);

    if (widget.controller != null) {
      widget.controller?.currentState = this;
    }
  }

  @override
  void dispose() {
    widget.focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (widget.focusNode.hasFocus) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(
        context,
      ).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _isHovered = false;
  }

  void hideSubMenu() {
    widget.focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: widget.focusNode,
      onHover: (isHovered) {
        if (isHovered && !_isHovered) {
          widget.focusNode.requestFocus();
          _isHovered = true;
        }
      },
      onPressed: () {},
      child: widget.title,
    );
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
          left: StoreManager().isEnglish ? (offset.dx - 20) : null,
          top: offset.dy + size.height,
          width: widget.width,
          child: TextButton(
            onPressed: () {
              //_focusNode.unfocus();
            },
            onHover: (isHovered) {
              if (isHovered && _isHovered) {
                widget.focusNode.requestFocus();
              } else {
                widget.focusNode.unfocus();
              }
            },
            child: widget.widget,
          )),
    );
  }
}
