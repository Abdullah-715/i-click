import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/widgets/app_toast.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../widgets/verification_email_bottom_sheet.dart';
import '../widgets/welcome_iclick_background.dart';

class VerificationEmailPage extends StatelessWidget {
  const VerificationEmailPage(
      {super.key, required this.email, required this.password});
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    return WelcomeIclickBackground(
      bottomSheet: BlocListener<AuthCubit, AuthState>(
          child: VerificationEmailBottomSheet(
            email: email,
            password: password,
          ),
          listener: (context, state) {
            if (state.status == DeafultBlocStatus.done) {
              AppToast.doneToast('A message has sent to your email');
            } else if (state.status == DeafultBlocStatus.error) {
              AppToast.errorToast(state.message);
            }
          }),
    );
  }
}

class EmptyBottomSheet extends StatelessWidget {
  final Widget child;
  const EmptyBottomSheet({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: AppColorManger.white, borderRadius: BorderRadius.circular(28)),
      width: 375.w,
      height: 580.h,
      child: Center(
        child: child,
      ),
    );
  }
}
