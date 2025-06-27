import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entity/chat_entity.dart';
import '../../../../core/error/failure.dart';
import '../entity/message_entity.dart';

abstract class ChatRepo {
  //? Repo for get all messages for chat :
  Either<Failure, Stream<List<dynamic>>> getAllMessages(
      {required String chatId});

  //? Repo for get last message :
  Future<Either<Failure, List<ChatEntity>>> getLastMessage();

  //? Repo for add message :
  Future<Either<Failure, Unit>> sendMessage({required MessageEntity message});

  //? Repo for add message :
  Future<Either<Failure, Unit>> sendImage(
      {required MessageEntity message, required File file});

  //? Repo for set message as readed :
  Future<Either<Failure, Unit>> readMessages({required String chatId});
}
