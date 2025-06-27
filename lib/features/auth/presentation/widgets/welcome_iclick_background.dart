import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../core/widgets/back_gradient_button.dart';

class WelcomeIclickBackground extends StatelessWidget {
  final Widget bottomSheet;
  const WelcomeIclickBackground({
    super.key,
    required this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: bottomSheet,
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 54.h),
            height: 200.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppPngManger.welcomeBack),
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                const BackOpacityButton(),
                SizedBox(height: 20.h),
                Center(
                  child: SvgPicture.asset(AppSvgManger.iclick),
                ),
                SizedBox(height: 260.h)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
