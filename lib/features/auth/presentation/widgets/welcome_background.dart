import 'package:flutter/material.dart';
import '../../../../core/resources/png_manger.dart';

class WelcomeBackGround extends StatelessWidget {
  final Widget bottomSheet;
  const WelcomeBackGround({
    super.key,
    required this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(AppPngManger.welcome),
      bottomSheet: bottomSheet,
    );
  }
}
