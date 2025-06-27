import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/functions/validation_functions.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_form_field.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../logic/auth_logic.dart';

class ResetPasswordBottomSheet extends StatelessWidget {
  const ResetPasswordBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    String email = '';
    return Form(
      key: key,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
            color: AppColorManger.white,
            borderRadius: BorderRadius.circular(28)),
        width: 375.w,
        height: 580.h,
        child: Column(
          children: [
            Text(
              'TYPE YOUR EMAIL',
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
                'We will send you instruction on how to reset your password',
                textAlign: TextAlign.center,
                style: Styles.body1.copyWith(color: AppColorManger.textPrimary),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: MainFormField(
                  validator: (val) => AppValidation().validation(val),
                  onChanged: (val) => email = val,
                  hint: 'Email',
                  horizontalPadding: 20.w,
                  verticalPadding: 13.h,
                  hintStyle: Styles.body3.copyWith(
                    color: AppColorManger.textPlaceholder,
                  ),
                )),
            SizedBox(
              height: 97.h,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) => AuthLogic.resetPasswordListenner(
                  state: state, context: context),
              builder: (context, state) {
                if (state.status == DeafultBlocStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return MainButton(
                  label: 'SEND',
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context
                          .read<AuthCubit>()
                          .forgetPassword(password: email, accesToken: '');
                    }
                  },
                );
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
      ),
    );
  }
}
