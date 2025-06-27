import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';
import '../../../../router/routes.dart';
import 'package:intl/intl.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';

class MessageSent extends StatelessWidget {
  final MessageEntity message;
  final ChatEntity chat;
  final bool seePic;
  const MessageSent({
    super.key,
    required this.seePic,
    required this.message,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //? picture section :
          seePic
              ? UserImageOrLetterWidget(
                  id: chat.firstUserId == AppSharedPref.getUserId()
                      ? chat.firstUserId!
                      : chat.secondUserId!,
                  image: chat.firstUserImage == AppSharedPref.getUserImage()
                      ? chat.firstUserImage!
                      : chat.secondUserImage!,
                  name: chat.firstUserName == AppSharedPref.getUserName()
                      ? chat.firstUserName!
                      : chat.secondUserName!)
              : SizedBox(
                  width: 30.w,
                ),
          SizedBox(width: 9.w),

          //? Message section :
          Container(
            constraints: message.type == MessageType.text
                ? BoxConstraints(maxWidth: 200.w)
                : null,
            width: message.type == MessageType.image ? 200.w : null,
            height: message.type == MessageType.image ? 200.w : null,
            margin: EdgeInsets.only(right: 55.w),
            padding: message.type == MessageType.text
                ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColorManger.black1,
                    blurRadius: 2,
                    offset: const Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(
                        (seePic || message.type == MessageType.image)
                            ? 20.r
                            : 0),
                    bottomRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(
                        message.type == MessageType.text ? 0 : 20.r)),
                color: message.type == MessageType.text
                    ? AppColorManger.white
                    : Colors.transparent),
            child: message.type == MessageType.text
                ? Text(
                    message.messageText ?? '',
                    style: Styles.body3
                        .copyWith(color: AppColorManger.textPrimary),
                    softWrap: true,
                  )
                : GestureDetector(
                    onTap: () {
                      GoRouter.of(context)
                          .push(AppRoutes.imagePage, extra: message.image);
                    },
                    child: Hero(
                      tag: message.image ?? '',
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: CachedNetworkImage(
                            imageUrl: message.image ?? '',
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
          ),
          const Spacer(),
          Text(
            DateFormat.Hm().format(DateTime.parse(message.createTime)),
            style: Styles.body4.copyWith(color: AppColorManger.black1),
          )
        ],
      ),
    );
  }
}
