import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../features/splash/cubit/deep_linking_cubit.dart';
import '../core/cubit/navigation_cubit/navigation_cubit.dart';
import '../core/cubit/short_users_cubit/short_users_cubit.dart';
import '../features/notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../router/app_router.dart';
import '../core/theme/them_app.dart';
import 'package:toastification/toastification.dart';

import '../injection/injection_container.dart' as di;

class Context {
  static final navKey = GlobalKey<NavigatorState>();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return ToastificationWrapper(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => NavigationCubit(),
              ),
              BlocProvider(
                create: (context) => di.sl<ShortUsersCubit>(),
              ),
              BlocProvider(
                create: (context) => di.sl<NotificationCubit>(),
              ),
              BlocProvider(
                create: (context) => DeepLinkingCubit(),
              ),
            ],
            child: MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              theme: appTheme,
              key: Context.navKey,
            ),
          ),
        );
      },
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
    );
  }
}
