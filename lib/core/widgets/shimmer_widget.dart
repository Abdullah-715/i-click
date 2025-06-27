import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../resources/color_manger.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        gradient: LinearGradient(colors: [
          AppColorManger.greyEight,
          AppColorManger.greyFive,
          AppColorManger.greyEight,
          AppColorManger.greyFive
        ]),
        period: const Duration(milliseconds: 1000),
        child: child);
  }
}
