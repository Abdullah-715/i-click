import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../domain/entity/message_entity.dart';
import '../cubit/chat_cubit.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/resources/svg_manger.dart';

class SendMessageField extends StatefulWidget {
  final String reciverId;
  const SendMessageField({
    super.key,
    required this.reciverId,
  });

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
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
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state.status == DeafultBlocStatus.done &&
            state.event == ChatEvent.selectImage) {
          final message = MessageEntity(
            type: MessageType.image,
            isReaded: false,
            senderId: AppSharedPref.getUserId()!,
            senderName: AppSharedPref.getUserName()!,
            receiverId: widget.reciverId,
            messageText: '',
            createTime: DateTime.now().toString(),
            senderImage: AppSharedPref.getUserImage()!,
          );
          context.read<ChatCubit>().sendImage(message: message);
        }

        if (state.event == ChatEvent.sendImage) {
          if (state.status == DeafultBlocStatus.error) {
            AppToast.errorToast(state.msg);
          } 
        }
      },
      child: Container(
        color: AppColorManger.greyBackground,
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 0, 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppColorManger.primaryLinearTow,
                  AppColorManger.primaryLinearOne,
                ])),
                child: MaterialButton(
                  onPressed: () {
                    context.read<ChatCubit>().selectMessagePicture();
                  },
                  child: SvgPicture.asset(
                    AppSvgManger.image,
                    colorFilter:
                        ColorFilter.mode(AppColorManger.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: TextField(
                controller: controller,
                minLines: 1,
                maxLines: 6,
                onChanged: (val) {
                  if (val.isEmpty) {
                    visible = false;
                  } else {
                    visible = true;
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: border(),
                  errorBorder: border(),
                  focusedBorder: border(),
                  enabledBorder: border(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  hintText: 'Type something...',
                  hintStyle: Styles.body4
                      .copyWith(color: AppColorManger.textPlaceholder),
                ),
              ),
            ),
            visible
                ? GestureDetector(
                    onTap: () {
                      if (controller.text != null &&
                          controller.text.isNotEmpty) {
                        final message = MessageEntity(
                          senderId: AppSharedPref.getUserId() ?? '',
                          senderName: AppSharedPref.getUserName() ?? '',
                          receiverId: widget.reciverId,
                          messageText: controller.text,
                          isReaded: false,
                          image: null,
                          createTime: DateTime.now().toString(),
                          senderImage: AppSharedPref.getUserImage() ?? '',
                          type: MessageType.text,
                        );
                        context.read<ChatCubit>().sendMessage(message: message);
                        controller.clear();
                        visible = false;
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: SvgPicture.asset(
                        AppSvgManger.send,
                        colorFilter: ColorFilter.mode(
                            AppColorManger.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                  )
                : SizedBox(width: 39.w)
          ],
        ),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(
          width: 2,
          color: AppColorManger.primaryColor,
        ));
  }
}
