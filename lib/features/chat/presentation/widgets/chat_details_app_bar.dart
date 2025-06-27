import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../domain/entity/chat_entity.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';

class ChatDetailsAppBar extends StatelessWidget {
  final ChatEntity chat;
  const ChatDetailsAppBar({
    super.key,
    required this.chat,
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
                AppSvgManger.backLeft,
                width: 24.w,
              ),
            ),
            Text(
                chat.firstUserName == AppSharedPref.getUserName()
                    ? chat.secondUserName!
                    : chat.firstUserName!,
                style: Styles.title1),
            SizedBox(width: 24.w)
          ]),
    );
  }
}
