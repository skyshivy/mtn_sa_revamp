import 'package:flutter/widgets.dart';

class CustomScrollController {
  static late ScrollController _scrollCont;
  static loadMoreInitialize(ScrollController scrollCont, Function() loadMore) {
    _scrollCont = scrollCont;
    _scrollCont.addListener(() {
      _scrollListener(() {
        loadMore();
      });
    });
  }

  static _scrollListener(Function() bottom) {
    if (_scrollCont.offset >= _scrollCont.position.maxScrollExtent) {
      print("\n reach the bottom CustomScrollController \n");
      bottom();
    }
    if (_scrollCont.offset <= _scrollCont.position.minScrollExtent &&
        !_scrollCont.position.outOfRange) {
      print("\n reach the top CustomScrollController\n");
    }
  }
}
