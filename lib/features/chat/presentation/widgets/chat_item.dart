import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/functions/date_time_function.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../domain/entity/chat_entity.dart';
import '../cubit/chat_cubit.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';
import '../../../../router/routes.dart';

class ChatItem extends StatelessWidget {
  final ChatEntity message;
  const ChatItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pop = await GoRouter.of(context)
            .push(AppRoutes.chatDetailsPage, extra: message);
        if (pop == null) {
          context.read<ChatCubit>().getLastMessage();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        width: double.infinity,
        height: 103.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColorManger.black1,
              blurRadius: 1,
              offset: const Offset(1, 1),
            ),
          ],
          color: checkColor(),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserImageOrLetterWidget(
              id: message.firstUserId == AppSharedPref.getUserId()
                  ? message.secondUserId!
                  : message.firstUserId!,
              image: message.firstUserImage == AppSharedPref.getUserImage()
                  ? message.secondUserImage!
                  : message.firstUserImage!,
              name: message.firstUserName == AppSharedPref.getUserName()
                  ? message.secondUserName!
                  : message.firstUserName!,
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.firstUserName == AppSharedPref.getUserName()
                        ? message.secondUserName!
                        : message.firstUserName!,
                    style: Styles.title2,
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: 20.h, maxWidth: 100.w),
                    child: Text(
                      message.lastMessageText == null ||
                              message.lastMessageText!.isEmpty
                          ? 'image'
                          : message.lastMessageText!,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.body4
                          .copyWith(color: AppColorManger.textSecondry),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            getDateForApp(message.lastMessageCreateTime!),
                            style: Styles.body5.copyWith(
                                color: AppColorManger.textPlaceholder)),
                      ),
                      SizedBox(width: 155.w),
                      Text(
                        message.firstUserId == AppSharedPref.getUserId()
                            ? message.firstUserCount.toString()
                            : message.secondUserCount.toString(),
                        style: Styles.body4
                            .copyWith(color: AppColorManger.textPrimary),
                      ),
                      SizedBox(width: 6.w),
                      SvgPicture.asset(
                        AppSvgManger.comment,
                        width: 20.w,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Color checkColor() {
    //* Last message isnt from me :
    if (message.firstUserId == AppSharedPref.getUserId()) {
      if (message.firstUserCount != 0) {
        return AppColorManger.primaryBackground;
      } else {
        return AppColorManger.white;
      }
    } else {
      if (message.secondUserCount != 0) {
        return AppColorManger.primaryBackground;
      } else {
        return AppColorManger.white;
      }
    }
  }
}
