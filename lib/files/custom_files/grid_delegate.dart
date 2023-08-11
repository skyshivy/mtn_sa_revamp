import 'package:flutter/material.dart';

SliverGridDelegateWithMaxCrossAxisExtent delegate(
    {double mainAxisExtent = 280,
    double maxCrossAxisExtent = 290,
    double mainAxisSpacing = 20,
    double crossAxisSpacing = 20}) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    childAspectRatio: 0.911,
    mainAxisExtent: mainAxisExtent,
    maxCrossAxisExtent: maxCrossAxisExtent,
    mainAxisSpacing: mainAxisSpacing,
    crossAxisSpacing: crossAxisSpacing,
  );
}
