import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../cubit/navigation_cubit/navigation_cubit.dart';
import 'add_story_avatar.dart';
import '../../resources/color_manger.dart';
import '../../resources/styles.dart';
import '../../resources/svg_manger.dart';
import '../../widgets/main_form_field.dart';
import '../../../router/routes.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 60.h, right: 13.w, left: 13.w, bottom: 13.h),
      decoration: BoxDecoration(
        color: AppColorManger.white,
      ),
      child: Row(
        children: [
          const AddStoryAvatar(),
          SizedBox(
            width: 24.w,
          ),
          SizedBox(
            width: 230.w,
            height: 41.h,
            child: MainFormField(
              onTap: () {
                context.read<NavigationCubit>().changeIndex(1);
              },
              readOnly: true,
              hint: 'Search',
              hintStyle:
                  Styles.body4.copyWith(color: AppColorManger.textPlaceholder),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 6.w),
                child: SvgPicture.asset(AppSvgManger.searchColored),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 20.w),
              verticalPadding: 8.h,
              horizontalPadding: 14.w,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),

          //? Chat icon :
          GestureDetector(
            onTap: () {
              GoRouter.of(context).push(AppRoutes.chatPage);
            },
            child: Hero(
              tag: 'msg',
              child: Container(
                width: 36.w,
                height: 36.w,
                padding: EdgeInsets.all(9.w),
                decoration: BoxDecoration(
                    color: AppColorManger.greyBackground,
                    shape: BoxShape.circle),
                child: SvgPicture.asset(
                  AppSvgManger.chat,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
