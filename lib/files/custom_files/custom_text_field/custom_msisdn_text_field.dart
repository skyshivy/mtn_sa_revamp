import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/font.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomMsisdnTextField extends StatefulWidget {
  final String text;
  final String? hintText;
  final bool isMsisdn;
  final bool enabled;
  final double height;
  final Color borderColor;
  final Color bgColor;
  final Iterable<String>? autoFillHint;
  final double? fontSiz;
  final Widget? rightWidget;
  final Color countryCodeColor;
  final double cornerRadius;
  final Widget? prefixWidget;
  final bool addCountryCode;

  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  const CustomMsisdnTextField({
    super.key,
    this.isMsisdn = true,
    this.prefixWidget,
    this.height = 45,
    this.enabled = true,
    this.autoFillHint,
    this.cornerRadius = 25,
    this.countryCodeColor = greyDark,
    this.bgColor = transparent,
    this.rightWidget,
    this.fontSiz = 18,
    this.addCountryCode = true,
    this.hintText = enterMobileNumberStr,
    this.onChanged,
    this.onSubmit,
    required this.text,
    this.borderColor = grey,
    //required this.controller,
  });
  @override
  State<StatefulWidget> createState() => _CustomMsisdnTextFieldSate();
}

class _CustomMsisdnTextFieldSate extends State<CustomMsisdnTextField> {
  final TextEditingController controller = TextEditingController();
  Key key = Key('New');
  late FocusNode _node1;
  bool _focused1 = false;
  @override
  void initState() {
    _node1 = FocusNode();
    _node1.addListener(_handleFocusChange);
    super.initState();
  }

  void _handleFocusChange() {
    if (_node1.hasFocus != _focused1) {
      setState(() {
        _focused1 = _node1.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.text;
    return Container(
      height: widget.height,
      decoration: mainDecoration(),
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          prefixContainerWidget(),
          Expanded(child: textField()),
          widget.rightWidget ?? const SizedBox()
        ],
      )),
    );
  }

  Widget prefixContainerWidget() {
    return widget.prefixWidget ??
        (widget.addCountryCode ? countryCode() : const SizedBox(width: 20));
  }

  Widget countryCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: widget.addCountryCode
          ? CustomText(
              title: countryCodeStr.tr,
              fontName: FontName.medium,
              textColor: widget.countryCodeColor,
              fontSize: widget.fontSiz ?? fontSize(12, 16),
            )
          : const SizedBox(width: 10),
    );
  }

  BoxDecoration mainDecoration() {
    return BoxDecoration(
      //color: yellow,
      color: widget.bgColor,
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(widget.cornerRadius),
    );
  }

  Widget textField() {
    // textEditingController.selection = TextSelection.fromPosition(
    //     TextPosition(offset: textEditingController.text.length));
    controller.text = widget.text;
    return ResponsiveBuilder(
      builder: (context, si) {
        return TextField(
          focusNode: _node1,
          autofillHints: widget.autoFillHint,
          controller: textEditingController(),
          enabled: widget.enabled,
          onSubmitted: (value) {
            widget.onSubmit!(value);
          },
          onChanged: (value) {
            widget.onChanged!(value);
          },

          style: TextStyle(
              fontFamily: FontName.medium.name,
              fontSize: widget.fontSiz ?? (si.isMobile ? 12 : 16)),
          decoration: inputDecoration(si),
          keyboardType: TextInputType.phone,

          inputFormatters: inputFormate, // Only numbers can be entered
        );
      },
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

  List<TextInputFormatter> get inputFormate {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(widget.isMsisdn
          ? StoreManager().msisdnLength
          : StoreManager().otpLength),
    ];
  }

  InputDecoration inputDecoration(SizingInformation si) {
    return InputDecoration(
      hintText: widget.hintText?.tr,
      isDense: true,
      hintStyle: TextStyle(
          fontFamily: FontName.medium.name,
          fontSize: widget.fontSiz ?? (si.isMobile ? 12 : 16)),
      border: InputBorder.none,
    );
  }
}
