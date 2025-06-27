import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entity/chat_entity.dart';
import '../../../../core/error/failure.dart';
import '../entity/message_entity.dart';
import '../repo/chat_repo.dart';
import 'chat_base_use_case.dart';

class ChatUseCase extends ChatBaseUseCase {
  final ChatRepo repo;

  ChatUseCase({required this.repo});
  @override
  Either<Failure, Stream<List<dynamic>>> getAllMessages(
      {required String chatId}) {
    return repo.getAllMessages(chatId: chatId);
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getLastMessage() async {
    return await repo.getLastMessage();
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      {required MessageEntity message}) async {
    return await repo.sendMessage(message: message);
  }

  @override
  Future<Either<Failure, Unit>> readMessages({required String chatId}) async {
    return await repo.readMessages(chatId: chatId);
  }

  @override
  Future<Either<Failure, Unit>> sendImage(
      {required MessageEntity message, required File file}) async {
    return await repo.sendImage(message: message , file: file);
  }
}
