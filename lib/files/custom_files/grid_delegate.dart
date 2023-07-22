import 'package:flutter/material.dart';

SliverGridDelegateWithMaxCrossAxisExtent delegate() {
  return const SliverGridDelegateWithMaxCrossAxisExtent(
      childAspectRatio: 0.911,
      mainAxisExtent: 280,
      maxCrossAxisExtent: 290,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20);
}
