// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomOnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const CustomOnHover({Key? key, required this.builder}) : super(key: key);

  @override
  _CustomOnHoverState createState() => _CustomOnHoverState();
}

class _CustomOnHoverState extends State<CustomOnHover> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    // on hover animation movement matrix translation
    final hovered = Matrix4.identity()..translate(0, 0, 0);
    final transform = isHovered ? hovered : Matrix4.identity();

    // when user enter the mouse pointer onEnter method will work
    // when user exit the mouse pointer from MouseRegion onExit method will work
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 3000),
        transform: transform, // animation transformation hovered.
        child:
            widget.builder(isHovered), // build the widget passed from main.dart
      ),
    );
  }

  //used to set bool isHovered to true/false
  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
