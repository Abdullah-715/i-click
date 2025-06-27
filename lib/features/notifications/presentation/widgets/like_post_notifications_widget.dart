import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/functions/date_time_function.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../domain/entity/notification_entity.dart';
import '../../../../router/routes.dart';

class LikePostNotificationWidget extends StatelessWidget {
  const LikePostNotificationWidget({
    super.key,
    required this.notification,
  });

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRoutes.postDetailsPage,
            extra: {'post_id': notification.data});
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 14.h, 14.w, 14.h),
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          color: notification.isReadded!
              ? AppColorManger.white
              : AppColorManger.primaryBackground,
          boxShadow: [
            BoxShadow(
              color: AppColorManger.black1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //?  Notification user image :
            UserImageOrLetterWidget(
                id: notification.senderId ?? '',
                image: notification.senderImageUrl ?? '',
                name: notification.senderName ?? ''),
            SizedBox(width: 14.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //?  Notification user name :
                Text(
                  notification.senderName ?? '',
                  style: Styles.title2.copyWith(color: AppColorManger.black2),
                ),
                SizedBox(height: 4.h),
                Text.rich(
                  //?  Notification user action :
                  TextSpan(
                      text: 'liked ',
                      style:
                          Styles.body4.copyWith(color: AppColorManger.black1),
                      children: [
                        TextSpan(
                            text: '"your post"',
                            style: Styles.body4
                                .copyWith(color: AppColorManger.primaryColor))
                      ]),
                ),
                const Spacer(),
                //?  Notification user time :
                Text(
                  getDateForApp(notification.createTime ?? ''),
                  style: Styles.body5
                      .copyWith(color: AppColorManger.textPlaceholder),
                )
              ],
            ),
            const Spacer(),
            //?  Notification post image :
            Container(
              width: 89.w,
              height: 64.h,
              alignment: Alignment.topRight,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 9.h, right: 9.w),
                    child: CachedNetworkImage(
                        imageUrl: notification.postImage ?? ''),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SvgPicture.asset(AppSvgManger.heartColored),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
