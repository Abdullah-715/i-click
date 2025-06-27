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

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
        height: 572.h,
        child: Column(
          children: [
            MainFormField(
              maxLines: 1,
              validator: (val) => AppValidation().emailValidation(val),
              onChanged: (val) => email = val,
              hint: 'Email',
              horizontalPadding: 20.w,
              verticalPadding: 13.h,
              hintStyle: Styles.body3.copyWith(
                color: AppColorManger.textPlaceholder,
              ),
            ),
            const Spacer(
              flex: 2,
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
            const Spacer(
              flex: 4,
            ),
            
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) =>
                  AuthLogic.loginListenner(state: state, context: context),
              builder: (context, state) {
                if (state.status == DeafultBlocStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return MainButton(
                  label: 'LOG IN',
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      context
                          .read<AuthCubit>()
                          .login(email: email, password: password);
                    }
                  },
                );
              },
            ),
            const Spacer(
              flex: 4,
            ),
            
            SizedBox(
                width: 224.w,
                height: 90.h,
                child: Image.asset(AppPngManger.threeTriangles)),
            const Spacer(
              flex: 4,
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account? ",
                  style: Styles.body3.copyWith(color: AppColorManger.black1),
                ),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    GoRouter.of(context).pushReplacement(AppRoutes.signupPage);
                  },
                  child: Text(
                    "SIGN UP",
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
