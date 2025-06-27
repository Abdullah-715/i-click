import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/resources/svg_manger.dart';

class AddPostAppBar extends StatelessWidget {
  final VoidCallback onTap;
  const AddPostAppBar({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      margin: EdgeInsets.only(top: 44.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: SvgPicture.asset(
                AppSvgManger.xColored,
                width: 24.w,
              ),
            ),
            Text('Add Post', style: Styles.title1),
            GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                AppSvgManger.addCircle,
                colorFilter: ColorFilter.mode(
                    AppColorManger.primaryColor, BlendMode.srcIn),
              ),
            ),
          ]),
    );
  }
}
