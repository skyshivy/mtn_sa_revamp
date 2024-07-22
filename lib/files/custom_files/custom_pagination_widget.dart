import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mtn_sa_revamp/files/custom_pagination/custom_pagination.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';

Widget customLoadMoreData(int totalCount, Function(int)? onTap,
    {int? pagePerDisplay}) {
  return Visibility(
    visible: !(totalCount < (pagePerDisplay ?? pagePerCount)),
    child: CustomPagination(
      totalItem: totalCount,
      tappedIndex: (p0) {
        if (onTap != null) {
          onTap(p0);
        }
      },
    ),
  );
}
