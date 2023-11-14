import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'panel_style.g.dart';

@riverpod
double heightFactor(HeightFactorRef ref, BuildContext context) {
  return MediaQuery.of(context).size.height > 800 ? 0.8 : 0.9;
}
