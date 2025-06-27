import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/svg_manger.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: AppColorManger.circleAvatarBackground,
        child: SvgPicture.asset(AppSvgManger.google),
      ),
    );
  }
}
