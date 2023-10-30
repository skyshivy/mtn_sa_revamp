library hover_menu;

import 'package:flutter/material.dart';

import 'hover_menu_controller.dart';

class HoverMenu extends StatefulWidget {
  final Widget title;
  final double? width;
  final Widget widget;
  final FocusNode focusNode;
  //final List<Widget> items;

  final HoverMenuController? controller;

  HoverMenu({
    Key? key,
    required this.title,
    //this.items = const [],
    this.width,
    this.controller,
    required this.widget,
    required this.focusNode,
  }) : super(key: key);

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
      Overlay.of(context).insert(_overlayEntry!);
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
          left: offset.dx,
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
          )
          //widget.widget,
          // TextButton(
          //   onPressed: () {},
          //   onHover: (isHovered) {
          //     if (isHovered && _isHovered) {
          //       _focusNode.requestFocus();
          //     } else {
          //       _focusNode.unfocus();
          //     }
          //   },
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       SizedBox(height: 20),
          //       Container(
          //           height: 50,
          //           color: Colors.red,
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             scrollDirection: Axis.horizontal,
          //             itemCount: 10,
          //             itemBuilder: (context, index) {
          //               return InkWell(
          //                 onTap: () {
          //                   _focusNode.unfocus();
          //                 },
          //                 child: Padding(
          //                   padding: EdgeInsets.only(
          //                       top: 2,
          //                       bottom: 2,
          //                       right: 2,
          //                       left: index == 0 ? 2 : 0),
          //                   child: Container(
          //                     height: 40,
          //                     width: 40,
          //                     color: Colors.amber,
          //                   ),
          //                 ),
          //               );
          //             },
          //           )
          //           // ListView(
          //           //     padding: EdgeInsets.zero,
          //           //     shrinkWrap: true,
          //           //     children: widget.items),
          //           ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
