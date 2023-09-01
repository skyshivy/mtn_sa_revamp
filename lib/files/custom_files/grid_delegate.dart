import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

SliverGridDelegateWithMaxCrossAxisExtent delegate(SizingInformation si,
    {double? mainAxisExtent = 280,
    double? maxCrossAxisExtent = 290,
    double? mainAxisSpacing,
    double? crossAxisSpacing}) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    childAspectRatio: 0.911,
    mainAxisExtent: mainAxisExtent,
    maxCrossAxisExtent: maxCrossAxisExtent!,
    mainAxisSpacing: si.isMobile ? 8 : mainAxisSpacing ?? 20,
    crossAxisSpacing: si.isMobile ? 8 : crossAxisSpacing ?? 20,
  );
}
