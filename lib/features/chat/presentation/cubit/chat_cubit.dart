import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/functions/image_picker.dart';
import '../../../../core/functions/map_failure.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/message_entity.dart';
import '../../domain/usecases/chat_base_use_case.dart';
import 'package:logger/web.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.usecase) : super(ChatState.init());
  final ChatBaseUseCase usecase;

  //* For get last messages :
  Future<void> getLastMessage() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ChatEvent.getLastMessages,
    ));
    final data = await usecase.getLastMessage();
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, msg: mapFailure(failure))),
      (messages) => emit(
        state.copyWith(
          status: DeafultBlocStatus.done,
          lastMessages: messages,
        ),
      ),
    );
  }
  //*

  final supabaseClient = Supabase.instance.client;
  Future<void> getAllMessages({required String chatId}) async {
    if (state.messages.isEmpty) {
      emit(state.copyWith(
        status: DeafultBlocStatus.loading,
        event: ChatEvent.getMessages,
      ));
    }
    try {
      supabaseClient
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('chat_id', chatId)
          .order('id', ascending: true)
          .listen((data) {
            final messages =
                data.map((e) => MessageEntity.fromJson(e)).toList();
            if (messages.isNotEmpty &&
                !messages.last.isReaded &&
                messages.last.senderId != AppSharedPref.getUserId()) {
              readMessages(chatId: chatId);
            }
            emit(state.copyWith(
                status: state.messages.isEmpty ? DeafultBlocStatus.done : null,
                event: ChatEvent.getMessages,
                messages: messages));
          })
          .onError((e) {
            emit(state.copyWith(
                status: DeafultBlocStatus.error, msg: e.toString()));
          });
    } catch (e) {
      Logger().e('Error fetching messages: $e');
      emit(state.copyWith(status: DeafultBlocStatus.error, msg: e.toString()));
    }
  }

  Future<void> readMessages({required String chatId}) async {
    final data = await usecase.readMessages(chatId: chatId);
    data.fold(
      (failure) => Logger().e('Failed to read messages: $failure'),
      (done) => Logger().i('Messages marked as read'),
    );
  }


  //* This for send message :
  Future<void> sendMessage({required MessageEntity message}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ChatEvent.sendMessages,
    ));
    final data = await usecase.sendMessage(message: message);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, msg: mapFailure(failure))),
      (done) => emit(
        state.copyWith(
          status: DeafultBlocStatus.done,
        ),
      ),
    );
  }
  //*

  //* Select picture :
  Future<void> selectMessagePicture() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ChatEvent.selectImage,
    ));
    final file = await pickImage();
    if (file != null) {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: file));
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: null));
    }
  }
  //*

  //* Add Image :
  Future<void> sendImage({
    required MessageEntity message,
  }) async {
    emit(state.copyWith(
        status: DeafultBlocStatus.loading, event: ChatEvent.sendImage));
    if (state.file != null) {
      final data = await usecase.sendImage(message: message, file: state.file!);
      data.fold(
          (failure) => emit(state.copyWith(
              status: DeafultBlocStatus.error, msg: mapFailure(failure))),
          (done) =>
              emit(state.copyWith(status: DeafultBlocStatus.done, file: null)));
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done));
    }
  }

  //*
}
