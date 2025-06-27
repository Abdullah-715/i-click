import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/search/presentation/cubit/cubit/search_cubit.dart';
import '../home/pages/home_page.dart';
import '../shared/app_shared_prefrences.dart';
import '../cubit/navigation_cubit/navigation_cubit.dart';
import 'navigation_bar/add_button.dart';
import 'navigation_bar/navigation_bar.dart';
import '../../features/notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/post/presentation/cubit/post_cubit/post_cubit.dart';
import '../../features/profile/presentation/cubit/profile_data/profile_data_cubit.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/story/presentation/cubit/cubit/story_cubit_cubit.dart';
import '../../injection/injection_container.dart' as di;
import '../../router/routes.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => di.sl<PostCubit>()..getAllPosts(),
          ),
          BlocProvider(
            create: (context) => di.sl<StoryCubit>()..getAllStories(),
          ),
        ],
        child: const HomePage(),
      ),
      BlocProvider(
        create: (context) => di.sl<SearchCubit>(),
        child: const SearchPage(),
      ),
      BlocProvider(
        create: (context) => di.sl<NotificationCubit>()..getAllNotifications(),
        child: const NotificationsPage(),
      ),
      BlocProvider(
        create: (context) => di.sl<ProfileCubit>()
          ..getProfileData(profileId: AppSharedPref.getUserId()!),
        child: const ProfilePage(),
      )
    ];
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            return list[state.index];
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AddButton(
          onPressed: () async {
            GoRouter.of(context).push(AppRoutes.addPostPage);
            
          },
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
