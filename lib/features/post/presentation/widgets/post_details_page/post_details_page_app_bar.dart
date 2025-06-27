import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/api/api_send_notification.dart';
import '../../../../notifications/domain/entity/notification_entity.dart';
import '../../../../notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../../cubit/post_cubit/post_cubit.dart';
import 'package:like_button/like_button.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/resources/svg_manger.dart';
import '../../../../../core/shared/app_shared_prefrences.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../../../router/routes.dart';
import 'package:uuid/uuid.dart';

class PostDetailsPageAppBar extends StatelessWidget {
  final PostEntity post;
  const PostDetailsPageAppBar({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    bool isLiked = post.likes?.contains(AppSharedPref.getUserId()) ?? false;
    context.read<PostCubit>().like(isLike: isLiked);

    return Container(
      width: double.infinity,
      height: 48.h,
      margin: EdgeInsets.only(top: 44.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //?  Back button :
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: SvgPicture.asset(
                AppSvgManger.backLeft,
                width: 24.w,
              ),
            ),
            const Spacer(),

            //?  Like icon :
            LikeButton(
              isLiked: isLiked,
              onTap: (like) async {
                isLiked = !isLiked;

                context
                    .read<PostCubit>()
                    .likePost(postId: post.postId!)
                    .then((_) {
                  if (!post.likes!.contains(AppSharedPref.getUserId()) &&
                      post.postCreatorId != AppSharedPref.getUserId()) {
                    final notification = NotificationEntity(
                      createTime: DateTime.now().toString(),
                      id: const Uuid().v4(),
                      data: post.postId,
                      isReadded: false,
                      postImage: post.postImageUrl,
                      resciverId: post.postCreatorId,
                      senderId: AppSharedPref.getUserId(),
                      senderImageUrl: AppSharedPref.getUserImage(),
                      senderName: AppSharedPref.getUserName(),
                      title:
                          '${AppSharedPref.getUserName()} has liked your post',
                      type: NotificationType.likePost,
                    );
                    context
                        .read<NotificationCubit>()
                        .addNotification(notification: notification);
                  }
                });

                return !like;
              },
            ),
            SizedBox(width: 20.w),

            //?  Edit post icon :
            if (post.postCreatorId == AppSharedPref.getUserId())
              GestureDetector(
                onTap: () async {
                  final data = await GoRouter.of(context)
                      .push(AppRoutes.editPostPage, extra: post);
                  if (data == null) {
                    context.read<PostCubit>().getPost(postId: post.postId!);
                  }
                },
                child: SvgPicture.asset(
                  AppSvgManger.editSquare,
                  width: 24.w,
                ),
              ),
          ]),
    );
  }
}
