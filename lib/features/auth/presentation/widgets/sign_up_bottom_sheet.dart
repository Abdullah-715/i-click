import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/functions/validation_functions.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_form_field.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../logic/auth_logic.dart';
import 'password_field.dart';
import '../../../../router/routes.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String name = '';
    String email = '';
    String password = '';
    final key = GlobalKey<FormState>();
    return Form(
      key: key,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
        decoration: BoxDecoration(
            color: AppColorManger.white,
            borderRadius: BorderRadius.circular(28)),
        width: 375.w,
        height: 535.h,
        child: Column(
          children: [
            MainFormField(
              maxLines: 1,
              onChanged: (val) => email = val,
              validator: (val) => AppValidation().emailValidation(val),
              hint: 'Email',
              horizontalPadding: 20.w,
              verticalPadding: 13.h,
              hintStyle: Styles.body3.copyWith(
                color: AppColorManger.textPlaceholder,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            MainFormField(
              maxLines: 1,
              onChanged: (val) => name = val,
              validator: (val) => AppValidation().validation(val),
              hint: 'Name',
              horizontalPadding: 20.w,
              verticalPadding: 13.h,
              hintStyle: Styles.body3.copyWith(
                color: AppColorManger.textPlaceholder,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            PasswordField(
              onChanged: (val) => password = val,
              validator: (val) => AppValidation().passwordValidation(val),
              hint: 'Password',
              horizontalPadding: 20.w,
              verticalPadding: 13.h,
              hintStyle: Styles.body3.copyWith(
                color: AppColorManger.textPlaceholder,
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) => AuthLogic.signupListenner(
                state: state,
                context: context,
                email: email,
                password: password,
              ),
              builder: (context, state) {
                if (state.status == DeafultBlocStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return MainButton(
                  label: 'SIGN UP',
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context.read<AuthCubit>().signup(
                          email: email, password: password, userName: name);
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
                width: 224.w,
                height: 90.h,
                child: Image.asset(AppPngManger.threeTriangles)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have account? ",
                  style: Styles.body3.copyWith(color: AppColorManger.black1),
                ),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRoutes.loginPage);
                  },
                  child: Text(
                    "SIGN IN",
                    style: Styles.body3
                        .copyWith(color: AppColorManger.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
