import 'dart:io';

import 'package:dartz/dartz.dart';
import '../entity/chat_entity.dart';
import '../../../../core/error/failure.dart';
import '../entity/message_entity.dart';

abstract class ChatBaseUseCase {
  //? Base for get all messages for chat :
  Either<Failure, Stream<List<dynamic>>> getAllMessages(
      {required String chatId});

  //? Base for get last message :
  Future<Either<Failure, List<ChatEntity>>> getLastMessage();

  //? Base for add message :
  Future<Either<Failure, Unit>> sendMessage({required MessageEntity message});

  //? Base for read message :
  Future<Either<Failure, Unit>> readMessages({required String chatId});

  //? Repo for add message :
  Future<Either<Failure, Unit>> sendImage({required MessageEntity message ,required File file});

}
