// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_click_app/core/api/api_send_notification.dart';
import 'package:i_click_app/core/resources/enum_manger.dart';
import 'package:i_click_app/core/resources/styles.dart';
import 'package:i_click_app/features/notifications/domain/entity/notification_entity.dart';
import 'package:i_click_app/features/notifications/presentation/cubit/cubit/notification_cubit.dart';
import 'package:i_click_app/features/notifications/presentation/widgets/comment_post_notification_widget.dart';
import 'package:i_click_app/features/notifications/presentation/widgets/follow_notifications.dart';
import 'package:i_click_app/features/notifications/presentation/widgets/like_post_notifications_widget.dart';
import 'package:i_click_app/features/notifications/presentation/widgets/notiication_shimmer_list.dart';
import 'package:i_click_app/features/profile/presentation/pages/profile_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      key: const PageStorageKey('notification_page'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              EdgeInsets.only(top: 54.h, left: 20.w, right: 20.w, bottom: 10.h),
          child: Text(
            'Activity',
            style: Styles.heading,
          ),
        ),
        BlocConsumer<NotificationCubit, NotificationState>(
            listener: (context, state) {
          if (state.status == DeafultBlocStatus.done &&
              state.event == NotificationEvent.getAllNotifications) {
            context.read<NotificationCubit>().setNotificatiosAsReadded();
          }
        }, builder: (context, state) {
          if (state.event == NotificationEvent.getAllNotifications) {
            if (state.status == DeafultBlocStatus.loading) {
              return const NotificationShimmerList();
            } else if (state.status == DeafultBlocStatus.error) {
              return ErrorTextWidget(
                  message: state.message,
                  isList: false,
                  onRefresh: () async {
                    context.read<NotificationCubit>().getAllNotifications();
                  });
            }
          }
          if (state.notifications.isEmpty) {
            return Expanded(
              child: Center(
                child: Text(
                  "There is no notifications yet...",
                  style: Styles.bodySemibold,
                ),
              ),
            );
          }

          return NotificationsListWidget(notifications: state.notifications);
        })
      ],
    );
  }
}

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({
    super.key,
    required this.notifications,
  });

  final List<NotificationEntity> notifications;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshList(
        onRefresh: () async {
          context.read<NotificationCubit>().getAllNotifications();
        },
        child: ListView.separated(
            separatorBuilder: (context, _) => SizedBox(
                  height: 10.h,
                ),
            padding: EdgeInsets.only(
                top: 16.h, left: 14.w, right: 14.w, bottom: 95.h),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              switch (notifications[index].type) {
                case NotificationType.follow:
                  return FollowNotificationWidget(
                    notification: notifications[index],
                  );

                case NotificationType.comment:
                  return CommentPostNotificationWidget(
                      notification: notifications[index]);

                case NotificationType.likePost:
                  return LikePostNotificationWidget(
                      notification: notifications[index]);

                default:
                  return const SizedBox();
              }
            }),
      ),
    );
  }
}
