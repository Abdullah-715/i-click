import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/png_manger.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 190.h,
            child: Stack(
              children: [
                //?  For background :
                Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: Image.asset(AppPngManger.radiusBackground)),

                //?  For picture :
                Positioned(
                  bottom: 0,
                  right: 148.w,
                  left: 148.w,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                        color: AppColorManger.white, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            child: Column(
              children: [
                //?  User name :
                Container(
                  width: 70.w,
                  height: 15.h,
                  color: AppColorManger.black1,
                ),
                SizedBox(height: 16.h),
                //?  User bio :
                Container(
                  width: 90.w,
                  height: 15.h,
                  color: AppColorManger.black1,
                ),
                SizedBox(height: 25.h),

                //?  Followers - Followings :
                Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: AppColorManger.greyBackground,
                      borderRadius: BorderRadius.circular(6.r)),
                ),
                SizedBox(height: 20.h),
                
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            child: Container(
              height: 39.h,
              decoration: BoxDecoration(
                color: AppColorManger.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ),

          //?  Posts :
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 95.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15.w,
                crossAxisSpacing: 15.w,
              ),
              itemCount: 4,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: AppColorManger.greyFive,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                width: 100,
                height: 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
