import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_toast.dart';
import '../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../injection/injection_container.dart';
import 'package:logger/logger.dart';
import '../../../core/resources/png_manger.dart';
import '../../../core/shared/app_shared_prefrences.dart';
import '../cubit/deep_linking_cubit.dart';
import '../widgets/splash_page_body.dart';
import '../../../router/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late StreamSubscription sub;
  bool deepLinkHandled = false;

  void checkDeepLinking() async {
    //? check :
    final initialUri = await AppLinks().getInitialLink();
    if (initialUri != null) {
      Logger().d('Initial URI: $initialUri');
      deepLinkHandled = true;
      handleUri(initialUri);
    }

    //? listen :
    sub = AppLinks().uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        Logger().d('Stream URI: $uri');
        deepLinkHandled = true;
        handleUri(uri);
      } else {
        deepLinkHandled = false;
      }
    });
  }

  void handleUri(Uri uri) {
    final params = uri.queryParameters;
    if (uri.path == '/auth/v1/verify' && params.containsKey('token')) {
      Logger().d('Path: ${uri.path}, Token: ${params['token']}');
      context.read<DeepLinkingCubit>().verifyAccount(params['token']!);
    } else if (uri.path == '/auth/v1/reset-password' &&
        params.containsKey('token')) {
      Logger().d('Path: ${uri.path}, Token: ${params['token']}');
      context.read<DeepLinkingCubit>().resetPassword(params['token']!);
    } else if (uri.path == '/auth/v1/change-email' &&
        params.containsKey('token')) {
      Logger().d('Path: ${uri.path}, Token: ${params['token']}');
      context.read<DeepLinkingCubit>().changeEmail(params['token']!);
    }
  }

  void navigateFunction() {
    if (AppSharedPref.getUserId() != null) {
      GoRouter.of(context).pushReplacement(AppRoutes.homePage);
    } else {
      GoRouter.of(context).pushReplacement(AppRoutes.getStartedPage);
    }
  }

  @override
  void initState() {
    super.initState();
    checkDeepLinking();
    Future.delayed(const Duration(seconds: 5), () {
      if (!deepLinkHandled) {
        navigateFunction();
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<DeepLinkingCubit, DeepLinkingState>(
        listener: (context, state) {
          Logger().e('Listener triggered with state: ${state.status}');
          if (state.status == DeepLinkingStatus.initial) {
            navigateFunction();
          } else if (state.status == DeepLinkingStatus.verify) {
            context.read<AuthCubit>().verifiyEmail(accesToken: state.token);
            AppToast.doneToast('Your email has been verified!');
            Logger().f('****************************');
            navigateFunction();
          
          } else if (state.status == DeepLinkingStatus.changeEmail) {
          } else if (state.status == DeepLinkingStatus.resetPassword) {}
        },
        child: Scaffold(
            body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppPngManger.backGroundIntro),
            ),
          ),
          child: const SplashPageBody(),
        )),
      ),
    );
  }
}
