import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/api/api_send_notification.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/main_button.dart';
import '../../domain/entity/comment_entity.dart';
import '../cubit/add_comment/add_comment_cubit.dart';
import '../../../notifications/domain/entity/notification_entity.dart';
import '../../../notifications/presentation/cubit/cubit/notification_cubit.dart';
import '../../../post/domain/entity/post_entity.dart';
import 'package:uuid/uuid.dart';

class AddCommentField extends StatefulWidget {
  final PostEntity post;
  const AddCommentField({
    super.key,
    required this.post,
  });

  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  late TextEditingController controller;
  bool visible = false;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54.h,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: AppColorManger.white,
      child: Row(
        children: [
          //? User image to make comment :
          Container(
            width: 30.h,
            height: 30.h,
            alignment: AppSharedPref.getUserImage() != AppSharedPref.getUserId()
                ? null
                : Alignment.center,
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
                color: AppColorManger.greyFive, shape: BoxShape.circle),
            child: AppSharedPref.getUserImage() != AppSharedPref.getUserId()
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: AppSharedPref.getUserImage()!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Text(
                    AppSharedPref.getUserName()?[0].toUpperCase() ?? '',
                    style: Styles.body4
                        .copyWith(color: AppColorManger.primaryColor),
                  ),
          ),

          //? Add comment text field :
          Expanded(
            child: TextField(
              onChanged: (val) {
                if (val.isEmpty) {
                  visible = false;
                } else {
                  visible = true;
                }
                setState(() {});
              },
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add a comment',
                hintStyle: Styles.body4
                    .copyWith(color: AppColorManger.textPlaceholder),
              ),
            ),
          ),

          Visibility(
            visible: visible,
            child: MainButton(
              onPressed: () {
                final id = const Uuid().v4();
                //? Create the comment :
                final comment = CommentEntity(
                  postId: widget.post.postId,
                  userId: AppSharedPref.getUserId(),
                  commentId: id,
                  title: controller.text,
                  createTime: DateTime.now().toString(),
                  userImage: AppSharedPref.getUserImage(),
                  userName: AppSharedPref.getUserName(),
                );

                //? Add the comment :
                BlocProvider.of<AddCommentCubit>(context)
                    .addComments(
                        postId: widget.post.postId!.toString(),
                        comment: comment)
                    .then((_) {
                  if(widget.post.postCreatorId != AppSharedPref.getUserId()){
                    final notification = NotificationEntity(
                    createTime: DateTime.now().toString(),
                    id: const Uuid().v4(),
                    data: comment.postId,
                    isReadded: false,
                    postImage: widget.post.postImageUrl,
                    resciverId: widget.post.postCreatorId,
                    senderId: AppSharedPref.getUserId(),
                    senderImageUrl: AppSharedPref.getUserImage(),
                    senderName: AppSharedPref.getUserName(),
                    title: '${AppSharedPref.getUserName()} has commented on your post!',
                    type: NotificationType.comment,
                  );

                  context
                      .read<NotificationCubit>()
                      .addNotification(notification: notification);
               
                  } });
                //? Clear the text :
                controller.clear();
                setState(() {
                  visible = !visible;
                });
              },
              label: 'Add',
              labelStyle: Styles.body4.copyWith(color: AppColorManger.white),
              width: 47.w,
              height: 32.h,
            ),
          )
        ],
      ),
    );
  }
}
