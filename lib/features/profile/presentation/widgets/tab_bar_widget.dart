import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';

class TabBarWidget extends StatelessWidget {
  final int postsCount;
  final int storiesCont;
  final bool isSearch;
  const TabBarWidget({
    super.key,
    this.isSearch = false,
    required this.postsCount,
    required this.storiesCont,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Container(
        height: 39.h,
        decoration: BoxDecoration(
          color: AppColorManger.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: TabBar(
          dividerColor: Colors.transparent,
          automaticIndicatorColorAdjustment: true,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: AppColorManger.textPlaceholder,
          labelColor: AppColorManger.primaryColor,
          indicatorColor: AppColorManger.white,
          indicatorWeight: 2,
          indicator: BoxDecoration(
            color: AppColorManger.primaryBackground,
            borderRadius: BorderRadius.circular(5.r),
          ),
          labelStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 16.sp,
              ),
          tabs: [
            Tab(
              child: Text(
                !isSearch ? '$postsCount Shot' : '$postsCount Users',
                style: Styles.title2,
              ),
            ),
            Tab(
                child: Text(
              !isSearch ? '$storiesCont Stories' : '$storiesCont Posts',
              style: Styles.title2,
            )),
          ],
        ),
      ),
    );
  }
}
