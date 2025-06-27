import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'notification_item_shimmer.dart';

class NotificationShimmerList extends StatelessWidget {
  const NotificationShimmerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 16.h, left: 14.w, right: 14.w, bottom: 95.h),
      child: const Column(
        children: [
          NotificationItemShimmer(),
          NotificationItemShimmer(),
          NotificationItemShimmer(),
        ],
      ),
    );
  }
}
