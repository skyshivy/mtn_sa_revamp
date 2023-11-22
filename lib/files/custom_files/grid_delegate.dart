import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

SliverGridDelegateWithMaxCrossAxisExtent delegate(SizingInformation si,
    {double? mainAxisExtent = 200,
    double? maxCrossAxisExtent = 250,
    double? mainAxisSpacing,
    double? crossAxisSpacing}) {
  return SliverGridDelegateWithMaxCrossAxisExtent(
    childAspectRatio: 0.8,
    mainAxisExtent: mainAxisExtent,
    maxCrossAxisExtent: maxCrossAxisExtent!,
    mainAxisSpacing: si.isMobile ? 8 : mainAxisSpacing ?? 20,
    crossAxisSpacing: si.isMobile ? 8 : crossAxisSpacing ?? 20,
  );
}
