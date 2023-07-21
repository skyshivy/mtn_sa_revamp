import 'package:flutter/material.dart';

class HomeRecoTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: listView(),
    );
  }

  Widget listView() {
    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: mainContainer(),
          );
        });
  }

  Container mainContainer() {
    return Container(
      child: InkWell(
        onTap: () {
          //value.selectedTab(index);
        },
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [instrinsicWidget()],
        ),
      ),
    );
  }

  IntrinsicWidth instrinsicWidget() {
    return IntrinsicWidth(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "put value",
          //style: textStyle(),
        ),
        const SizedBox(height: 5),
        selectionIndicator()
      ],
    ));
  }

/*
  TextStyle textStyle() {
    return 
    TextStyle(
        fontFamily: Constants.fontFamily,
        fontWeight:
            value.selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        fontSize: sizeInfo.isMobile ? 14 : 20,
        color: value.selectedIndex == index ? CColor.yelow : Colors.grey);
  }
*/
  Container selectionIndicator() {
    return Container(
      height: 3,
      //width: ?,
      // color: value.selectedIndex == index
      //     ? CColor.yelow
      //     : Colors.transparent,
    );
  }
}
