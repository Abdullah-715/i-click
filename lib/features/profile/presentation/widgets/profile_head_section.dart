import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/api/api_send_notification.dart';
import '../../../../core/resources/font_manger.dart';
import '../../../../core/widgets/alert/app_alert.dart';
import '../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import '../../../notifications/domain/entity/notification_entity.dart';
import '../../../notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../../../../injection/injection_container.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/follow_button.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/profile_data/profile_data_cubit.dart';
import '../../../../router/routes.dart';

class ProfileHeadSection extends StatelessWidget {
  final bool isMyPage;
  final UserEntity user;
  const ProfileHeadSection({
    super.key,
    required this.isMyPage,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == DeafultBlocStatus.loading) {
            GoRouter.of(context).pop();
            AppAlert.lodingAlert(context);
          }
          if (state.status == DeafultBlocStatus.done) {
            GoRouter.of(context).pop();
            GoRouter.of(context).pushReplacement(AppRoutes.loginPage);
            AppSharedPref.clear();
          }
        },
        child: SizedBox(
          width: double.infinity,
          height: 190.h,
          child: Stack(
            children: [
              //?  For background :
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(AppPngManger.radiusBackground)),

              //?  For picture :
              Positioned(
                bottom: 0,
                right: 148.w,
                left: 148.w,
                child: Container(
                  padding: EdgeInsets.all(4.h),
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                      color: AppColorManger.white, shape: BoxShape.circle),
                  child: UserImageOrLetterWidget(
                      width: 80.w,
                      height: 80.w,
                      fontSize: AppFontSizeManger.s24,
                      id: user.id ?? '',
                      image: user.imageUrl ?? '',
                      name: user.name ?? ''),
                ),
              ),

              //?  For user profile :
              Positioned(
                  top: 44.h,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    width: 375.w,
                    height: 56.h,
                    child: Row(
                      children: [
                        isMyPage
                            ? Builder(builder: (context) {
                                return IconButton(
                                    onPressed: () {
                                      AppAlert.mainDialog(context,
                                          title: 'Log out',
                                          body:
                                              'Are you sure you want to log out?',
                                          button: 'logout', onPress: () {
                                        context.read<AuthCubit>().logout();
                                      });
                                    },
                                    icon: SvgPicture.asset(AppSvgManger.logOut,
                                        width: 30.w,
                                        colorFilter: ColorFilter.mode(
                                            AppColorManger.white,
                                            BlendMode.srcIn)));
                              })
                            : IconButton(
                                onPressed: () {
                                  GoRouter.of(context).pop();
                                },
                                icon: SvgPicture.asset(AppSvgManger.backLeft,
                                    colorFilter: ColorFilter.mode(
                                        AppColorManger.white,
                                        BlendMode.srcIn))),
                        const Spacer(),
                        Text(
                          '@${user.displayName}',
                          style: Styles.title4
                              .copyWith(color: AppColorManger.white),
                        ),
                        const Spacer(),
                        isMyPage
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  final data = await GoRouter.of(context).push(
                                      AppRoutes.editProfilePage,
                                      extra: user) as bool?;
                                  if (data != null && data == true) {
                                    context
                                        .read<ProfileCubit>()
                                        .getProfileData(profileId: user.id!);
                                  }
                                },
                                icon: SvgPicture.asset(
                                  width: 24.w,
                                  AppSvgManger.settings,
                                  colorFilter: ColorFilter.mode(
                                      AppColorManger.white, BlendMode.srcIn),
                                ))
                            : BlocConsumer<ProfileCubit, ProfileState>(
                                listener: (context, state) {
                                  if (state.event == ProfileEvent.follow) {
                                    if (state.status ==
                                        DeafultBlocStatus.error) {
                                      AppToast.errorToast(state.message);
                                    } else if (state.status ==
                                            DeafultBlocStatus.done &&
                                        state.event !=
                                            ProfileEvent.getProfile) {
                                      context
                                          .read<ProfileCubit>()
                                          .getProfileData(
                                              profileId: user.id!,
                                              isFirst: false);
                                      AppToast.additinalToast(
                                          'The changes was saved');
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  bool isFollow = state.isFollow ??
                                      user.followers!
                                          .contains(AppSharedPref.getUserId());
                                  return isFollow
                                      ? InkWell(
                                          onTap: () {
                                            context
                                                .read<ProfileCubit>()
                                                .changeFollow(isFollow);
                                            context
                                                .read<ProfileCubit>()
                                                .followProfile(
                                                    profileId: user.id!);
                                          },
                                          child: Text('Following',
                                              style: Styles.body4.copyWith(
                                                  color: AppColorManger.white)),
                                        )
                                      : FollowButton(
                                          withBorder: false,
                                          width: 73.w,
                                          height: 36.h,
                                          onTap: () {
                                            context
                                                .read<ProfileCubit>()
                                                .changeFollow(isFollow);
                                            context
                                                .read<ProfileCubit>()
                                                .followProfile(
                                                    profileId: user.id!)
                                                .then((_) {
                                              final notification =
                                                  NotificationEntity(
                                                createTime:
                                                    DateTime.now().toString(),
                                                id: const Uuid().v4(),
                                                data: AppSharedPref.getUserId(),
                                                isReadded: false,
                                                resciverId: user.id,
                                                senderId:
                                                    AppSharedPref.getUserId(),
                                                senderImageUrl: AppSharedPref
                                                    .getUserImage(),
                                                title:
                                                    '${AppSharedPref.getUserName()} start following you!',
                                                senderName:
                                                    AppSharedPref.getUserName(),
                                                type: NotificationType.follow,
                                              );
                                              context
                                                  .read<NotificationCubit>()
                                                  .addNotification(
                                                      notification:
                                                          notification);
                                            });
                                          },
                                        );
                                },
                              ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
