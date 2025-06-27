import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manger.dart';
import '../resources/styles.dart';

class MainButton extends StatelessWidget {
  final String label;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final void Function()? onPressed;
  const MainButton({
    super.key,
    required this.label,
    this.onPressed,
    this.width,
    this.height,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        //? This for make button on all container :
        height: height ?? 50.h,

        width: width ?? double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,

        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColorManger.primaryLinearTow,
            AppColorManger.primaryLinearOne,
          ]),
        ),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          height: height,
          child: Text(
            label,
            style: labelStyle ??
                Styles.bodySemibold.copyWith(
                  color: AppColorManger.white,
                ),
          ),
        ),
      ),
    );
  }
}
