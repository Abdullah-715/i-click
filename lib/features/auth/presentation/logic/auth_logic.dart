import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/app_toast.dart';
import '../cubit/auth_cubit/auth_cubit.dart';
import '../../../profile/presentation/cubit/profile_data/profile_data_cubit.dart';
import '../../../../router/routes.dart';

class AuthLogic {
  static void loginListenner({
    required AuthState state,
    required BuildContext context,
  }) {
    if (state.status == DeafultBlocStatus.error) {
      AppToast.errorToast(state.message);
    } else if (state.status == DeafultBlocStatus.done) {
      final id = AppSharedPref.getUserId();
      context.read<ProfileCubit>().getProfileData(profileId: id!);
      GoRouter.of(context).pushReplacement(AppRoutes.homePage);
    }
  }

  static void signupListenner({
    required AuthState state,
    required BuildContext context,
    required String email,
    required String password,
  }) {
    if (state.status == DeafultBlocStatus.error) {
      AppToast.errorToast(state.message);
    } else if (state.status == DeafultBlocStatus.done) {
      final data = {
        'email': email,
        'password': password,
      };
      GoRouter.of(context).push(AppRoutes.verificationEmailPage, extra: data);
    }
  }

  static void resetPasswordListenner({
    required AuthState state,
    required BuildContext context,
  }) {
    if (state.status == DeafultBlocStatus.error) {
      AppToast.errorToast(state.message);
    } else if (state.status == DeafultBlocStatus.done) {
      GoRouter.of(context).push(AppRoutes.finishResetPasswordPage);
    }
  }
}
