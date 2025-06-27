import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manger.dart';
import '../resources/styles.dart';

class FollowButton extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? withBorder;
  final void Function()? onTap;
  const FollowButton({
    super.key,
    this.height,
    this.width,
    this.withBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? 61.w,
        height: height ?? 32.h,
        decoration: BoxDecoration(
          color: AppColorManger.white,
          borderRadius: BorderRadius.circular(30.r),
          border: withBorder!
              ? Border.all(color: AppColorManger.primaryColor)
              : null,
        ),
        child: Text(
          'Follow',
          style: Styles.body4.copyWith(
              foreground: Paint()
                ..shader = LinearGradient(colors: [
                  AppColorManger.primaryLinearOne,
                  AppColorManger.primaryLinearTow,
                ]).createShader(Rect.fromLTWH(20, 0.0, 200.w, 70.h))),
        ),
      ),
    );
  }
}
