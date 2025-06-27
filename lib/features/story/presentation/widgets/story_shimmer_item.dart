import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryShimmerItem extends StatelessWidget {
  const StoryShimmerItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.h,
          height: 50.h,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        ),
        Container(
          width: 50.w,
          height: 10.h,
          margin: EdgeInsets.only(top: 2.h),
          color: Colors.black,
        )
      ],
    );
  }
}
