import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/model/faq_model.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:number_paginator/number_paginator.dart';

class CustomPagination extends StatefulWidget {
  const CustomPagination({Key? key, required this.totalItem}) : super(key: key);
  final int totalItem;
  @override
  _CustomPaginationState createState() => _CustomPaginationState();
}

class _CustomPaginationState extends State<CustomPagination> {
  NumberPaginatorController controller = NumberPaginatorController();
  int _numPages = 0;
  //int _currentPage = 0;
  @override
  void initState() {
    _numPages = 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NumberPaginator(
      config: NumberPaginatorUIConfig(
        height: 40,
        buttonPadding: const EdgeInsets.all(0),
        buttonTextStyle:
            TextStyle(fontFamily: FontName.bold.name, fontSize: 12),
        buttonUnselectedForegroundColor: red,
        buttonSelectedBackgroundColor: blue,
      ),
      controller: controller,
      numberPages: _numPages,
      onPageChange: (int index) {
        setState(() {
          //_currentPage = index;
          printCustom("Page tapped $index");
        });
      },
    );
  }
}
