import 'package:flutter/material.dart';
import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/colors.dart';

Gradient customGredient() {
  return LinearGradient(
    colors: [
      StoreManager().isEnglish ? darkGreen : lightGreen,
      StoreManager().isEnglish ? lightGreen : darkGreen,
    ],
  );
}

Gradient customImageGredient(
    {Color color1 = blackGredient, Color color2 = blackGredient}) {
  return LinearGradient(
    colors: [
      color1,
      color2,
    ],
  );
}
