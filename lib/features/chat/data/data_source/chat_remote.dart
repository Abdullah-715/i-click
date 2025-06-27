import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/api/api_send_notification.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/supabase/supabase_storage.dart';
import '../../domain/entity/chat_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entity/message_entity.dart';

abstract class ChatRemote {
  //? Remote for get all messages :
  Stream<List<dynamic>> getAllMessages({required String chatId});

  //? Remote for get last message :
  Future<List<ChatEntity>> getLastMessages();

  //? Remote for send message :
  Future<Unit> sendMessage({required MessageEntity message});

  //? Remote for read message :
  Future<Unit> readMessages({required String chatId});

  //? Remote for send image :
  Future<Unit> sendImage({required MessageEntity message, required File file});
}

class ChatRemoteImpl implements ChatRemote {
  final SupabaseClient supabaseClient;

  ChatRemoteImpl({required this.supabaseClient});
  @override
  Stream<List<dynamic>> getAllMessages({required String chatId}) {
    Stream<List<dynamic>> stream = supabaseClient
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('create_time', ascending: true)
        .asBroadcastStream();

    

    return stream;
  }

  @override
  Future<List<ChatEntity>> getLastMessages() {
    final params = {'user_id': AppSharedPref.getUserId()!};
    return ApiGetMethods<List<ChatEntity>>().get(
        query: params,
        url: ApiGet.getLastMessages,
        data: (response) {
          final dataDecoded = jsonDecode(response.response!.body) as Map<String, dynamic>;
          List postsDecoded = dataDecoded['data'];
          return postsDecoded.map((e) => ChatEntity.fromJson(e)).toList();
        });
  }

  @override
  Future<Unit> sendMessage({required MessageEntity message}) {
    final body = {'message_data': message.toJson()};
    return ApiPostMethods<Unit>()
        .post(
      url: ApiPost.sendMessage,
      data: (_) => unit,
      body: body,
    )
        .then((_) async {
      try {
        await ApiSendNotification().sendNotification(
          type: NotificationType.message,
          name: message.senderName,
          userId: message.receiverId,
          msg: message.messageText,
        );
      } catch (e) {}
      return unit;
    });
  }

  @override
  Future<Unit> readMessages({required String chatId}) {
    final body = {
      'chat_id_param': chatId,
      'receiver_id_param': AppSharedPref.getUserId()
    };
    return ApiPostMethods<Unit>().post(
      url: ApiPost.readMessage,
      data: (_) => unit,
      body: body,
    );
  }

  @override
  Future<Unit> sendImage(
      {required MessageEntity message, required File file}) async {
    final body = {
      'message_data':
          message.copyWith(image: await addImage(file: file)).toJson()
    };
    return ApiPostMethods<Unit>()
        .post(
      url: ApiPost.sendMessage,
      data: (_) => unit,
      body: body,
    )
        .then((_) async {
      await ApiSendNotification().sendNotification(
        type: NotificationType.message,
        name: message.senderName,
        userId: message.receiverId,
        msg: 'image',
      );
      return unit;
    });
  }

  Future<String> addImage({required File file}) {
    return SupabaseStorage<String>().uploadFile(
        file: file,
        data: (url) => url,
        bucket: 'messages',
        name: const Uuid().v1());
  }
}
