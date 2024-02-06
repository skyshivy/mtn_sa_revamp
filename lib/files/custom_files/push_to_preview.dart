import 'package:flutter/material.dart';

import 'package:mtn_sa_revamp/files/model/tune_info_model.dart';
import 'package:mtn_sa_revamp/files/screens/tune_preview_screen/tune_preview_screen.dart';

pushToTunePreView(BuildContext context, List<TuneInfo>? list, int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => TunePreviewScreen(
              tuneList: list ?? [],
              index: index,
            )),
  );
}
