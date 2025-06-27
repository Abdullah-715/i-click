import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/widgets/shimmer_widget.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 7.h,
      ),
      child: ShimmerWidget(
          child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColorManger.primaryBackground,
          borderRadius: BorderRadius.circular(10.r),
        ),
      )),
    );
  }
}
