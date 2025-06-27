
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/font_manger.dart';
import '../../../../core/widgets/alert/app_alert.dart';
import '../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../cubit/profile_data/profile_data_cubit.dart';

class EditProfilePageHead extends StatelessWidget {
  final UserEntity user;
  final bool isRefresh;
  const EditProfilePageHead({
    super.key,
    required this.user,
    required this.isRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 190.h,
        child: Stack(
          children: [
            //?  For background :
            Positioned(
                //?  bottom: 40.h,
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(AppPngManger.radiusBackground)),

            //?  For picture :
            Positioned(
                bottom: 0,
                right: 147.5.w,
                left: 147.5.w,
                child: UserImageOrLetterWidget(
                    fontSize: AppFontSizeManger.s24,
                    width: 80.w,
                    height: 80.w,
                    id: user.id ?? '',
                    image: context.watch<ProfileCubit>().state.url.isNotEmpty
                        ? context.watch<ProfileCubit>().state.url
                        : user.imageUrl ?? '',
                    name: user.name ?? '')),

            //?  For camera icon :
            Positioned(
              bottom: 0,
              right: 140.w,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) => Container(
                            height: 180.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select what you want:',
                                  style: Styles.title1,
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.read<ProfileCubit>().picImage();
                                      },
                                      splashRadius: 1,
                                      icon: Column(
                                        children: [
                                          SvgPicture.asset(
                                            width: 50.w,
                                            AppSvgManger.camera,
                                          ),
                                          Text(
                                            'New image',
                                            style: Styles.title2,
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: user.id == user.imageUrl
                                          ? null
                                          : () {
                                              AppAlert.mainDialog(context,
                                                  title: 'Delete image',
                                                  body:
                                                      'Are you sure you want to delete you image?',
                                                  button: 'Delete',
                                                  onPress: () {
                                                context
                                                    .read<ProfileCubit>()
                                                    .deleteImage();
                                              });
                                            },
                                      splashRadius: 1,
                                      icon: Column(
                                        children: [
                                          SvgPicture.asset(
                                            width: 50.w,
                                            AppSvgManger.delete,
                                            colorFilter: ColorFilter.mode(
                                              user.imageUrl != user.id
                                                  ? AppColorManger.error
                                                  : AppColorManger.greyFoor,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          Text(
                                            'delete image',
                                            style: Styles.title2.copyWith(
                                              color: user.imageUrl != user.id
                                                  ? AppColorManger.error
                                                  : AppColorManger.greyFoor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                 
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColorManger.primaryLinearTow,
                      AppColorManger.primaryLinearOne
                    ]),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  padding: EdgeInsets.all(4.w),
                  width: 28.w,
                  height: 28.w,
                  child: SvgPicture.asset(
                    AppSvgManger.camera,
                    colorFilter:
                        ColorFilter.mode(AppColorManger.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            //?  For text :
            Positioned(
              top: 44.h,
              right: 0,
              left: 0,
              child: Center(
                  child: Text(
                'Edit profile',
                style: Styles.title1.copyWith(color: AppColorManger.white),
              )),
            ),

            //?  For back button :
            Positioned(
                top: 34.h,
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).pop(isRefresh);
                    },
                    icon: SvgPicture.asset(AppSvgManger.backLeft,
                        colorFilter: ColorFilter.mode(
                            AppColorManger.white, BlendMode.srcIn))))
          ],
        ));
  }
}
