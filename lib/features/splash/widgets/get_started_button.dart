import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/resources/color_manger.dart';
import '../../../core/resources/styles.dart';
import '../../../router/routes.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pushReplacement(AppRoutes.loginPage);
      },
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColorManger.opacityButton.withOpacity(0.3)),
        child: Text(
          "Get Started",
          style: Styles.bodySemibold.copyWith(color: AppColorManger.white),
        ),
      ),
    );
  }
}
