import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../router/routes.dart';

class FinishResetPasswordBottomSheet extends StatelessWidget {
  const FinishResetPasswordBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: AppColorManger.white, borderRadius: BorderRadius.circular(28)),
      width: 375.w,
      height: 580.h,
      child: Column(
        children: [
          Text(
            'SET NEW PASSWORD',
            style: Styles.title2.copyWith(
                foreground: Paint()
                  ..shader = LinearGradient(colors: [
                    AppColorManger.primaryLinearTow,
                    AppColorManger.primaryLinearOne,
                  ]).createShader(Rect.fromLTWH(20, 0.0, 200.w, 70.h))),
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColorManger.primaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'A link to reset your password was sent to your email.',
              textAlign: TextAlign.center,
              style: Styles.body1.copyWith(color: AppColorManger.textPrimary),
            ),
          ),
          SizedBox(
            height: 190.h,
          ),
          MainButton(
            label: 'RESETED',
            onPressed: () {
              GoRouter.of(context).pushReplacement(AppRoutes.loginPage);
            },
          ),
          SizedBox(
            height: 65.h,
          ),
          SizedBox(
              width: 224.w,
              height: 90.h,
              child: Image.asset(AppPngManger.threeTriangles))
        ],
      ),
    );
  }
}
