import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final String hintText;
  final bool? isBorder;
  final Color? cursorColor;
  final Color? textColor;
  final Color? bgColor;
  final Color? hintColor;
  final double? fontSize;
  final bool? editEnable;
  final FontName fontName;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmit;
  final TextEditingController controller = TextEditingController();

  CustomTextField({
    super.key,
    this.bgColor = transparent,
    this.isBorder = true,
    required this.text,
    this.cursorColor,
    this.onChanged,
    this.onTap,
    this.onSubmit,
    this.textColor,
    this.fontSize = 14,
    this.hintText = pleaseEnterMsisdn,
    this.hintColor = textFieldPlaceHolderColor,
    this.fontName = FontName.medium,
    this.editEnable,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _node = FocusNode();
  bool _focused = false;
  @override
  void initState() {
    // TODO: implement initState
    _node.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      setState(() {
        _focused = _node.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: widget.bgColor,
          border: widget.isBorder! ? Border.all(color: greyDark) : null,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: textField(),
        )));
  }

  TextField textField() {
    widget.controller.text = widget.text;
    return TextField(
      autofocus: true,
      //key: _formKey,
      focusNode: _node,
      textInputAction: TextInputAction.done,
      enabled: widget.editEnable,
      autocorrect: false,
      enableSuggestions: false,
      controller: textEditingController(),
      cursorColor: widget.cursorColor,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmit,
      onTap: widget.onTap,
      decoration: inputDecoration(),
      style: textStyle(),
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontFamily: widget.fontName.name,
      color: widget.textColor,
      fontSize: widget.fontSize,
    );
  }

  TextEditingController textEditingController() {
    return TextEditingController.fromValue(
      TextEditingValue(
          text: widget.text.tr,
          selection: TextSelection(
            baseOffset: widget.text.length,
            extentOffset: widget.text.length,
          )),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      hintText: widget.hintText.tr,
      hintStyle: TextStyle(color: widget.hintColor),
      isDense: true,
      border: InputBorder.none,
    );
  }
}
