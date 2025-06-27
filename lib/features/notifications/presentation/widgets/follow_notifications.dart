//?  ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:i_click_app/core/functions/date_time_function.dart';
import 'package:i_click_app/core/resources/color_manger.dart';
import 'package:i_click_app/core/resources/styles.dart';
import 'package:i_click_app/core/widgets/follow_button.dart';
import 'package:i_click_app/core/widgets/user_image_or_letter_widget.dart';
import 'package:i_click_app/features/notifications/domain/entity/notification_entity.dart';
import 'package:i_click_app/router/routes.dart';

class FollowNotificationWidget extends StatelessWidget {
  const FollowNotificationWidget({
    super.key,
    required this.notification,
  });

  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context)
            .push(AppRoutes.profilePage, extra: notification.data);
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
                      text: 'started following ',
                      style:
                          Styles.body4.copyWith(color: AppColorManger.black1),
                      children: [
                        TextSpan(
                            text: '"you"',
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
            //?  Notification follow button :
            const FollowButton()
          ],
        ),
      ),
    );
  }
}
