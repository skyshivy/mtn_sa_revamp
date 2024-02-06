import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/enums/font_enum.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_print.dart';
import 'package:mtn_sa_revamp/files/custom_files/custom_text/custom_text.dart';
import 'package:mtn_sa_revamp/files/custom_files/hover/custom_hover.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';
import 'package:mtn_sa_revamp/files/utility/image_name.dart';
import 'package:mtn_sa_revamp/files/utility/string.dart';
import 'package:popover/popover.dart';

popoverView(BuildContext context, Function() onTap, {bool isWishlist = false}) {
  showPopover(
    radius: 4,
    context: context,
    bodyBuilder: (context) => _listView(context, isWishlist, onTap),
    onPop: () => printCustom('Popover was popped!'),
    direction: PopoverDirection.bottom,
    width: 120,
    arrowHeight: 6,
    arrowWidth: 16,
  );
}

_listView(BuildContext context, bool isWishlist, Function() onTap) {
  return ListView(
    shrinkWrap: true,
    children: [
      InkWell(
        onTap: () {
          Navigator.of(context).pop();
          onTap();

          printCustom("Tapped");
        },
        child: CustomOnHover(
          builder: (isHovered) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: isHovered ? blue : white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        isWishlist ? deleteSvg : wishlistSvg,
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 4),
                      CustomText(
                          title: isWishlist ? deleteStr.tr : wishlistStr.tr,
                          fontName: FontName.medium,
                          textColor: isHovered ? white : black),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      )
    ],
  );
}
