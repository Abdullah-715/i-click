import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/chat/domain/entity/chat_entity.dart';
import '../features/chat/presentation/cubit/chat_cubit.dart';
import '../features/chat/presentation/pages/image_page.dart';
import '../core/widgets/main_page.dart';
import '../features/auth/domain/entities/user_entity.dart';
import '../features/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../features/auth/presentation/pages/finish_reset_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/auth/presentation/pages/verification_email_page.dart';
import '../features/chat/presentation/pages/chat_details_page.dart';
import '../features/chat/presentation/pages/chat_page.dart';
import '../features/comments/presentation/cubit/add_comment/add_comment_cubit.dart';
import '../features/comments/presentation/cubit/get_all_comments/get_all_comments_cubit.dart';
import '../features/post/domain/entity/post_entity.dart';
import '../features/post/presentation/cubit/post_cubit/post_cubit.dart';
import '../features/post/presentation/pages/add_post_page.dart';
import '../features/post/presentation/pages/edit_post_page.dart';
import '../features/post/presentation/pages/post_details_page.dart';
import '../features/profile/presentation/cubit/profile_data/profile_data_cubit.dart';
import '../features/profile/presentation/pages/edit_profile_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/splash/pages/get_started_page.dart';
import '../features/splash/pages/splash_page.dart';
import '../features/story/presentation/cubit/cubit/story_cubit_cubit.dart';
import '../features/story/presentation/pages/story_details_page.dart';
import 'routes.dart';
import '../injection/injection_container.dart' as di;

abstract class AppRouter {
  static final router = GoRouter(routes: [
    //?  Splash :
    GoRoute(
        path: AppRoutes.splashPage,
        builder: (context, state) => const SplashPage()),

    GoRoute(
        path: AppRoutes.getStartedPage,
        builder: (context, state) => const GetStartedPage()),

    //?  Auth :
    GoRoute(
        path: AppRoutes.loginPage,
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 250),
              reverseTransitionDuration: Duration(milliseconds: 250),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final begin = Offset(1, 0);
                final end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final offsetAnimation = curvedAnimation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => di.sl<AuthCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => di.sl<ProfileCubit>(),
                  ),
                ],
                child: const LoginPage(),
              ),
            )),
    GoRoute(
      path: AppRoutes.signupPage,
      pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: Duration(milliseconds: 250),
            reverseTransitionDuration: Duration(milliseconds: 250),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final begin = Offset(1, 0);
              final end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic,
              );
              final offsetAnimation = curvedAnimation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
        child: BlocProvider(
          create: (context) => di.sl<AuthCubit>(),
          child: const SignUpPage(),
        ),
      ),
    ),

    GoRoute(
        path: AppRoutes.finishResetPasswordPage,
        pageBuilder: (context, state) => CustomTransitionPage(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final begin = Offset(1, 0);
              final end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: const FinishResetPasswordPage())),

    GoRoute(
        path: AppRoutes.resetPasswordPage,
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 250),
              reverseTransitionDuration: Duration(milliseconds: 250),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final begin = Offset(1, 0);
                final end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final offsetAnimation = curvedAnimation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: BlocProvider(
                create: (context) => di.sl<AuthCubit>(),
                child: const ResetPasswordPage(),
              ),
            )),

    GoRoute(
        path: AppRoutes.verificationEmailPage,
        pageBuilder: (context, state) {
          final data = state.extra as Map;
          return CustomTransitionPage(
            transitionDuration: Duration(milliseconds: 250),
            reverseTransitionDuration: Duration(milliseconds: 250),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final begin = Offset(1, 0);
              final end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic,
              );
              final offsetAnimation = curvedAnimation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: BlocProvider(
              create: (context) => di.sl<AuthCubit>(),
              child: VerificationEmailPage(
                email: data['email'],
                password: data['password'],
              ),
            ),
          );
        }),

    //?  Home :
    GoRoute(
        path: AppRoutes.homePage,
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 250),
              reverseTransitionDuration: Duration(milliseconds: 250),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final begin = Offset(1, 0);
                final end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final offsetAnimation = curvedAnimation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: BlocProvider(
                create: (context) => di.sl<PostCubit>(),
                child: const MainPage(),
              ),
            )),
    //?  Profile :
    GoRoute(
        path: AppRoutes.profilePage,
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 250),
              reverseTransitionDuration: Duration(milliseconds: 250),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final begin = Offset(1, 0);
                final end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final offsetAnimation = curvedAnimation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => di.sl<AuthCubit>()),
                  BlocProvider(
                    create: (context) => di.sl<ProfileCubit>()
                      ..getProfileData(profileId: state.extra as String),
                  ),
                ],
                child: const Scaffold(body: ProfilePage()),
              ),
            )),
    GoRoute(
      path: AppRoutes.editProfilePage,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: Duration(milliseconds: 250),
        reverseTransitionDuration: Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = Offset(1, 0);
          final end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          final offsetAnimation = curvedAnimation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: BlocProvider(
          create: (context) => di.sl<ProfileCubit>(),
          child: EditProfilePage(
            user: state.extra as UserEntity,
          ),
        ),
      ),
    ),
    //?  Post :
    GoRoute(
      path: AppRoutes.postDetailsPage,
      builder: (context, state) {
        final data = state.extra as Map;

        final post = data['post'];
        final postId = data['post_id'];

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => di.sl<PostCubit>(),
            ),
            BlocProvider(
              create: (context) => di.sl<GetAllCommentsCubit>()
                ..getComments(postId: post.postId ?? ''),
            ),
            BlocProvider(
              create: (context) => di.sl<AddCommentCubit>(),
            ),
          ],
          child: PostDetailsPage(post: post, postId: postId),
        );
      },
    ),

    GoRoute(
        path: AppRoutes.postDetailsPageAnimation,
        pageBuilder: (context, state) {
          final data = state.extra as Map;

          final post = data['post'];
          final postId = data['post_id'];
          return CustomTransitionPage(
            transitionDuration: Duration(milliseconds: 250),
            reverseTransitionDuration: Duration(milliseconds: 250),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final begin = Offset(1, 0);
              final end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic,
              );
              final offsetAnimation = curvedAnimation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => di.sl<PostCubit>(),
                ),
                BlocProvider(
                  create: (context) => di.sl<GetAllCommentsCubit>()
                    ..getComments(postId: post.postId ?? ''),
                ),
                BlocProvider(
                  create: (context) => di.sl<AddCommentCubit>(),
                ),
              ],
              child: PostDetailsPage(post: post, postId: postId),
            ),
          );
        }),

    GoRoute(
      path: AppRoutes.addPostPage,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
        transitionDuration: Duration(milliseconds: 250),
        reverseTransitionDuration: Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = Offset(1, 0);
          final end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          final offsetAnimation = curvedAnimation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
          child: BlocProvider(
            create: (context) => di.sl<PostCubit>(),
            child: const AddPostPage(),
          ),
        );
      },
    ),

    GoRoute(
        path: AppRoutes.editPostPage,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
        transitionDuration: Duration(milliseconds: 250),
        reverseTransitionDuration: Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = Offset(1, 0);
          final end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          final offsetAnimation = curvedAnimation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
            child: BlocProvider(
              create: (context) => di.sl<PostCubit>(),
              child: EditPostPage(post: state.extra as PostEntity),
            ),
          );
        }),
    //?  Chat :
    GoRoute(
        path: AppRoutes.chatPage,
        builder: (context, state) => BlocProvider(
              create: (context) => di.sl<ChatCubit>()..getLastMessage(),
              child: const ChatPage(),
            )),

    GoRoute(
        path: AppRoutes.imagePage,
        builder: (context, state) => ImagePage(
              imageUrl: state.extra as String,
            )),

    GoRoute(
        path: AppRoutes.chatDetailsPage,
        pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: Duration(milliseconds: 250),
              reverseTransitionDuration: Duration(milliseconds: 250),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final begin = Offset(1, 0);
                final end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOutCubic,
                );
                final offsetAnimation = curvedAnimation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: BlocProvider(
                create: (context) => di.sl<ChatCubit>(),
                child: ChatDetailsPage(
                  chat: state.extra as ChatEntity,
                ),
              ),
            )),

    //?  Story :
    GoRoute(
        path: AppRoutes.storyDetailsPage,
        builder: (context, state) => BlocProvider(
              create: (context) => di.sl<StoryCubit>(),
              child: StoryDetailsPage(
                story: state.extra as UserEntity,
              ),
            )),
  ]);

  static Widget transitionsBuilder(
      context, animation, secondaryAnimation, child) {
    const begin = Offset(0, 1);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);

    final curveAnimation =
        CurvedAnimation(parent: animation, curve: Curves.ease);

    return SlideTransition(
      position: tween.animate(curveAnimation),
      child: child,
    );
  }
}
