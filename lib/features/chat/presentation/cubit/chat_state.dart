part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final DeafultBlocStatus status;
  final List<ChatEntity> lastMessages;
  final String msg;
  final ChatEvent event;
  final List<MessageEntity> messages;
  final File? file;

  const ChatState(
      {required this.status,
      required this.file,
      required this.lastMessages,
      required this.msg,
      required this.messages,
      required this.event});

  factory ChatState.init() => const ChatState(
        status: DeafultBlocStatus.initial,
        lastMessages: [],
        msg: '',
        event: ChatEvent.initial,
        messages: [],
        file: null,
      );

  @override
  List<Object> get props => [
        status,
        lastMessages,
        msg,
        event,
        messages,
      ];

  ChatState copyWith({
    DeafultBlocStatus? status,
    List<ChatEntity>? lastMessages,
    String? msg,
    ChatEvent? event,
    List<MessageEntity>? messages,
    File? file,
  }) {
    return ChatState(
      event: event ?? this.event,
      lastMessages: lastMessages ?? this.lastMessages,
      msg: msg ?? this.msg,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      file: file ?? this.file,
    );
  }
}
