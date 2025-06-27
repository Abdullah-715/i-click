import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../chat/domain/entity/chat_entity.dart';
import '../../../../router/routes.dart';
import '../../../../core/cubit/short_users_cubit/short_users_cubit.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../core/widgets/story/short_user_profile.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../pages/profile_page.dart';

class ProfileDetailsSection extends StatelessWidget {
  final UserEntity user;
  const ProfileDetailsSection({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      child: Column(
        children: [
          //?  User name :
          Text(
            user.name!,
            style: Styles.title1.copyWith(color: AppColorManger.textPrimary),
          ),
          SizedBox(height: 6.h),
          //?  User bio :
          Text(user.bio!.isEmpty ? 'No bio yet..' : user.bio!,
              textAlign: TextAlign.center,
              style: Styles.body3.copyWith(color: AppColorManger.greyEight)),
          user.id != AppSharedPref.getUserId()
              ? SizedBox(height: 20.h)
              : SizedBox(),
          user.id != AppSharedPref.getUserId()
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: MaterialButton(
                    onPressed: () {
                      final chat = ChatEntity(
                        firstUserId: AppSharedPref.getUserId(),
                        firstUserImage: AppSharedPref.getUserImage(),
                        firstUserName: AppSharedPref.getUserName(),
                        id: getChatId(
                            AppSharedPref.getUserId() ?? '', user.id ?? ''),
                        secondUserId: user.id,
                        secondUserImage: user.imageUrl,
                        secondUserName: user.name,
                      );
                      GoRouter.of(context)
                          .push(AppRoutes.chatDetailsPage, extra: chat);
                    },
                    padding: EdgeInsets.zero,
                    color: AppColorManger.greyBackground,
                    elevation: 0,
                    child: Container(
                      width: 130.w,
                      alignment: Alignment.center,
                      height: 40.h,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Start Chating',
                            style: Styles.body4
                                .copyWith(color: AppColorManger.greyTow),
                          ),
                          SvgPicture.asset(
                            AppSvgManger.chat,
                            colorFilter: ColorFilter.mode(
                                AppColorManger.greyTow, BlendMode.srcIn),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 20.h),
          Container(
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
                color: AppColorManger.greyBackground,
                borderRadius: BorderRadius.circular(6.r)),
            child: Row(
              children: [
                SizedBox(width: 48.w),
                //?  Folllowers :
                Text(
                  '${user.followers!.length} ',
                  style: Styles.bodySemibold
                      .copyWith(color: AppColorManger.textPrimary),
                ),
                InkWell(
                  onTap: () {
                    context
                        .read<ShortUsersCubit>()
                        .getUsersById(ids: user.followers!);
                    bottomSheetForProfiles(context,
                        title: 'Followers', ids: user.followers!);
                  },
                  child: Text(
                    'Followers',
                    style: Styles.bodySemibold
                        .copyWith(color: AppColorManger.textPlaceholder),
                  ),
                ),
                const Spacer(),
                //?  Follosings :
                Text(
                  '${user.followings!.length} ',
                  style: Styles.bodySemibold
                      .copyWith(color: AppColorManger.textPrimary),
                ),
                InkWell(
                  onTap: () {
                   bottomSheetForProfiles(context,
                        title: 'Following', ids: user.followings!);
                  },
                  child: Text(
                    'Following',
                    style: Styles.bodySemibold
                        .copyWith(color: AppColorManger.textPlaceholder),
                  ),
                ),
                SizedBox(width: 48.w),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          
        ],
      ),
    );
  }
}

String getChatId(String str1, String str2) {
  if (str1.toLowerCase().compareTo(str2.toLowerCase()) <= 0) {
    return '$str1+$str2';
  } else {
    return '$str2+$str1';
  }
}

Future<void> bottomSheetForProfiles(
  BuildContext context, {
  required String title,
  required List ids,
  String? emptyMessage,
}) {
  context.read<ShortUsersCubit>().getUsersById(ids: ids);
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      //?  height: 20,
      //?  width: 20,
      child: BlocBuilder<ShortUsersCubit, ShortUsersState>(
        builder: (context, state) {
          if (state.status == DeafultBlocStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == DeafultBlocStatus.error) {
            return ErrorTextWidget(
                message: state.message,
                onRefresh: () async {
                  context.read<ShortUsersCubit>().getUsersById(ids: ids);
                });
          }
          return ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: Styles.bodySemibold,
                ),
              ),
              if (state.users.isNotEmpty)
                ...state.users.map((user) => ShortUserProfile(
                      user: user,
                    )),
              if (state.users.isEmpty)
                Center(
                  child: Text(
                    emptyMessage ?? "There is no views yet!",
                    style: Styles.caption,
                  ),
                )
            ],
          );
        },
      ),
    ),
  );
}
