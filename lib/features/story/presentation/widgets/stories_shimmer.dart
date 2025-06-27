import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import 'story_shimmer_item.dart';

class StoriesShimmer extends StatelessWidget {
  const StoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 375.w,
        height: 75.h,
        child: ShimmerWidget(
          child: Row(
            children: [
              SizedBox(width: 24.w),
              const StoryShimmerItem(),
              SizedBox(width: 24.w),
              const StoryShimmerItem(),
              SizedBox(width: 24.w),
              const StoryShimmerItem(),
              SizedBox(width: 24.w),
              const StoryShimmerItem(),
              SizedBox(width: 24.w),
              const StoryShimmerItem(),
            ],
          ),
        ));
  }
}
