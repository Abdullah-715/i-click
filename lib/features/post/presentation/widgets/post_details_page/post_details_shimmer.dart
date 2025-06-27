import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/svg_manger.dart';
import '../../../../../core/widgets/shimmer_widget.dart';

class PostDetailsPageShimmer extends StatelessWidget {
  const PostDetailsPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          //?  App Bar :
          Container(
            width: double.infinity,
            height: 48.h,
            margin: EdgeInsets.only(top: 44.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //?  Back button :
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      AppSvgManger.backLeft,
                      width: 24.w,
                    ),
                  ),
                  const Spacer(),

                  //?  Like icon :
                  const ShimmerWidget(
                    child: Icon(
                      Icons.favorite,
                    ),
                  ),

                  SizedBox(width: 44.w),
                ]),
          ),

          Container(
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                //?  User image :
                Container(
                  width: 30.w,
                  height: 30.h,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                      color: AppColorManger.greyFive, shape: BoxShape.circle),
                ),

                //?  User name :
                Container(
                  width: 50.w,
                  height: 20.h,
                  color: AppColorManger.black1,
                ),
                const Spacer(),

                //?  Date time :
                Container(
                  width: 50.w,
                  height: 20.h,
                  color: AppColorManger.black1,
                ),
              ],
            ),
          ),

          Container(
            color: AppColorManger.black1,
            width: double.infinity,
            height: 200.h,
          ),
          SizedBox(
            width: double.infinity,
            height: 45.h,
            child: Row(
              children: [
                const Spacer(),
                //?  Comments count :
                SizedBox(width: 26.w),
                SvgPicture.asset(AppSvgManger.comment, width: 20.w),
                const Spacer(),
                //?  Likes count :
                SizedBox(width: 26.w),
                SvgPicture.asset(AppSvgManger.heartOutlineColored, width: 20.w),
                const Spacer()
              ],
            ),
          ),

          //?  Description :
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              color: AppColorManger.black1),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              color: AppColorManger.black1),

          //?  Comments :
          Container(
            width: double.infinity,
            height: 104.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(8.r)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //?  Comment user image :
                Container(
                  width: 30.w,
                  height: 30.h,
                  margin: EdgeInsets.only(right: 14.w),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColorManger.greyFive),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //?  Comment user name :
                    Container(
                      width: 50.w,
                      height: 15.h,
                      color: AppColorManger.black1,
                    ),
                    SizedBox(height: 4.h),

                    //?  Comment title :
                    Container(
                      width: 60.w,
                      height: 15.h,
                      color: AppColorManger.black1,
                    ),

                    SizedBox(height: 10.h),

                    //?  Commnet create time :
                    Container(
                      width: 50.w,
                      height: 15.h,
                      color: AppColorManger.black1,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
