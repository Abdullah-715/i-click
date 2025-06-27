import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/svg_manger.dart';

class PostShimmerItem extends StatelessWidget {
  const PostShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 13.w),
      width: 360.w,
      height: 319.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColorManger.black1, width: 0.5)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColorManger.greyFive),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 50.w,
                  height: 20.h,
                  color: AppColorManger.black1,
                ),
                const Spacer(),
                Container(
                  width: 60.w,
                  height: 20.h,
                  color: AppColorManger.black1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColorManger.greyFive,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  AppSvgManger.comment,
                  width: 17.w,
                ),
                SizedBox(
                  width: 16.w,
                ),
                SizedBox(width: 8.w),
                SvgPicture.asset(
                  AppSvgManger.heartOutlineColored,
                  width: 17.w,
                ),
                SizedBox(
                  width: 16.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
