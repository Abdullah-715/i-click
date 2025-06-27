import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_source/chat_remote.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';
import '../../domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatRemote remote;

  ChatRepoImpl({required this.remote});
  @override
  Either<Failure, Stream<List<dynamic>> > getAllMessages(
      {required String chatId}) {
    return CheckNet<Stream<List<dynamic>>>().checkRes(tryRight: (){
      final data = remote.getAllMessages(chatId: chatId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> getLastMessage() {
    return CheckNet<List<ChatEntity>>().checkNetResponse(tryRight: () async {
      final data = await remote.getLastMessages();
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> sendMessage({required MessageEntity message}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.sendMessage(message: message);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> readMessages({required String chatId}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.readMessages(chatId: chatId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> sendImage({required MessageEntity message,required  File file}) {
return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.sendImage(message: message, file: file);
      return Right(data);
    });
  }
}
