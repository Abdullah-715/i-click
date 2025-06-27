import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../resources/color_manger.dart';
import '../resources/svg_manger.dart';

class BackOpacityButton extends StatelessWidget {
  const BackOpacityButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: Container(
          width: 35.h,
          height: 35.h,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColorManger.white.withOpacity(0.3),
          ),
          child: SvgPicture.asset(
            AppSvgManger.backLeft,
            colorFilter:
                ColorFilter.mode(AppColorManger.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
