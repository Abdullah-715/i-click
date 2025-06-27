import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/png_manger.dart';

class NoItemsFoundWidget extends StatelessWidget {
  const NoItemsFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(94.w, 47.h, 94.w, 160.h),
      child: Image.asset(AppPngManger.noPostsFound),
    );
  }
}
