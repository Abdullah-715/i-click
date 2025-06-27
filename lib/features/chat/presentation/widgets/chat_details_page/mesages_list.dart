import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../../../core/resources/font_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/shared/app_shared_prefrences.dart';
import '../../../../../core/widgets/app_toast.dart';
import '../../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../../domain/entity/message_entity.dart';
import '../../cubit/chat_cubit.dart';
import '../message_recived.dart';
import '../message_sent.dart';
import '../../../../profile/presentation/pages/profile_page.dart';

class MessagesList extends StatefulWidget {
  final ChatEntity chat;
  const MessagesList({
    super.key,
    required this.chat,
  });

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: AppColorManger.greyBackground,
            child: CustomScrollView(
              controller: controller,
              slivers: [
                SliverToBoxAdapter(
                    child: SizedBox(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      UserImageOrLetterWidget(
                          width: 100.w,
                          height: 100.w,
                          fontSize: AppFontSizeManger.s24,
                          id: widget.chat.firstUserId ==
                                  AppSharedPref.getUserId()
                              ? widget.chat.secondUserId!
                              : widget.chat.firstUserId!,
                          image: widget.chat.firstUserImage ==
                                  AppSharedPref.getUserImage()
                              ? widget.chat.secondUserImage!
                              : widget.chat.firstUserImage!,
                          name: widget.chat.firstUserName ==
                                  AppSharedPref.getUserName()
                              ? widget.chat.secondUserName!
                              : widget.chat.firstUserName!),
                      Text(
                        widget.chat.firstUserName == AppSharedPref.getUserName()
                            ? widget.chat.secondUserName!
                            : widget.chat.firstUserName!,
                        style: Styles.body3,
                      ),
                      SizedBox(height: 50.h),
                    ],
                  ),
                )),
                SliverToBoxAdapter(
                  child: BlocConsumer<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state.status == DeafultBlocStatus.error) {
                        AppToast.errorToast(state.msg);
                      }

                      if (state.status == DeafultBlocStatus.done &&
                          state.messages.isNotEmpty) {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          controller.animateTo(
                            controller.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn,
                          );
                         
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state.status == DeafultBlocStatus.error &&
                          state.event == ChatEvent.getMessages &&
                          state.messages.isEmpty) {
                        return ErrorTextWidget(
                          message: state.msg,
                          onRefresh: () async {
                            context
                                .read<ChatCubit>()
                                .getAllMessages(chatId: widget.chat.id ?? '');
                          },
                          isList: false,
                        );
                      } else if (state.status == DeafultBlocStatus.loading &&
                          state.event == ChatEvent.getMessages &&
                          state.messages.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (state.messages.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 50.h),
                            child: Text(
                              "Start Your chat\n by send your first message here!",
                              style: Styles.body1
                                  .copyWith(color: AppColorManger.greyTow),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return doneList(state.messages);
                      }
                    },
                  ),
                ),
              ],
            )));
  }

  ListView doneList(List<MessageEntity> messages) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == messages.length) {
          if (messages.last.senderId == AppSharedPref.getUserId() &&
              messages.last.isReaded) {
            return Container(
              padding: EdgeInsets.only(right: 16.w),
              alignment: Alignment.centerRight,
              child: Text('seen',
                  style: Styles.body3.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColorManger.greyFoor)),
            );
          } else {
            return const SizedBox();
          }
        }

        //* For first messages :
        if (index < messages.length - 1) {
          if (messages[index].senderId == AppSharedPref.getUserId()) {
            //* For check the second message :
            if (messages[index + 1].senderId == AppSharedPref.getUserId()) {
              return MessageSent(
                  chat: widget.chat, seePic: false, message: messages[index]);
            } else {
              return MessageSent(
                chat: widget.chat,
                seePic: true,
                message: messages[index],
              );
            }
          } else {
            if (!(messages[index + 1].senderId == AppSharedPref.getUserId())) {
              return MessageRecived(
                  message: messages[index], seePic: false, chat: widget.chat);
            } else {
              return MessageRecived(
                  message: messages[index], chat: widget.chat, seePic: true);
            }
          }
        } else {
          //* For last message :
          if (messages[index].senderId == AppSharedPref.getUserId()) {
            return MessageSent(
              chat: widget.chat,
              seePic: true,
              message: messages[index],
            );
          } else {
            return MessageRecived(
                message: messages[index], seePic: true, chat: widget.chat);
          }
        }
      },
    );
  }
}
