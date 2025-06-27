import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../domain/entity/chat_entity.dart';
import '../cubit/chat_cubit.dart';
import '../widgets/chat_details_page/mesages_list.dart';
import '../widgets/chat_details_app_bar.dart';
import '../widgets/send_message_field.dart';

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({super.key, required this.chat});
  final ChatEntity chat;

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  @override
  void initState() {
    context.read<ChatCubit>().getAllMessages(chatId: widget.chat.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           ChatDetailsAppBar(chat: widget.chat,),
          MessagesList(
            chat: widget.chat,
          ),
          SendMessageField(
            reciverId: widget.chat.firstUserId == AppSharedPref.getUserId()
                ? widget.chat.secondUserId!
                : widget.chat.firstUserId!,
          )
        ],
      ),
    );
  }
}
