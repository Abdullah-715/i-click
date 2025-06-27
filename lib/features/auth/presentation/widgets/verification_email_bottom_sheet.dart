import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../../../../router/routes.dart';

class VerificationEmailBottomSheet extends StatelessWidget {
  final String email;
  final String password;
  const VerificationEmailBottomSheet({
    super.key,
    required this.email,
    required this.password,
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
            'VERIFICATION',
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
              'A message with verification code was sent to your email,\n open it and click on "Confirm your email" and back here to login!',
              textAlign: TextAlign.center,
              style: Styles.body1.copyWith(color: AppColorManger.textPrimary),
            ),
          ),
          SizedBox(
            height: 80.h,
          ),
          GestureDetector(
            //TODO
            onTap: () {
              context
                  .read<AuthCubit>()
                  .signup(userName: '', email: email, password: password);
            },
            child: Text(
              "DON'T RECEIVE THE CODE",
              style: Styles.caption.copyWith(
                color: AppColorManger.textPrimary,
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          MainButton(
            label: 'VERIFED',
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
