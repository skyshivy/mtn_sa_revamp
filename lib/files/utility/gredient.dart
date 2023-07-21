import 'package:flutter/material.dart';

Gradient customGredient(Color topC, Color bottomC) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      topC,
      bottomC,
    ],
  );
}
