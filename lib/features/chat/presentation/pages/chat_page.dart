import 'package:flutter/material.dart';
import '../widgets/chat_app_bar.dart';

import '../widgets/chat_items_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'msg',
      child: Scaffold(
        body: Column(
          children: [
            ChatAppBar(),
            ChatItemsList(),
          ],
        ),
      ),
    );
  }
}
