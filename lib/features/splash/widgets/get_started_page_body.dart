import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/color_manger.dart';
import '../../../core/resources/png_manger.dart';
import '../../../core/resources/styles.dart';
import '../../../core/resources/svg_manger.dart';
import 'get_started_button.dart';

class GetStartedPageBody extends StatelessWidget {
  const GetStartedPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70.h,
        ),
        SvgPicture.asset(AppSvgManger.iclick),
        SizedBox(
          height: 32.h,
        ),
        SizedBox(
          height: 422.h,
          width: 345.w,
          child: Image.asset(AppPngManger.firstScreenCenter),
        ),
        SizedBox(
          height: 32.h,
        ),
        Text(
          'SHARE - INSPIRE - CONNECT',
          style: Styles.caption
              .copyWith(color: AppColorManger.white, letterSpacing: 2),
        ),
        const GetStartedButton()
      ],
    );
  }
}
