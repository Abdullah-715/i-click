enum MessageType {
  text('text'),
  image('image');

  final String name;

  const MessageType(this.name);
}

class MessageEntity {
  final int? id;
  final String senderId;
  final String receiverId;
  final String? messageText;
  final String createTime;
  final String senderImage;
  final bool isReaded;
  final String senderName;
  final String? chatId;
  //TODO:
  final MessageType type;
  final String? image;

  MessageEntity({
    this.chatId,
    required this.type,
    this.image,
    required this.isReaded,
    this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.messageText,
    required this.createTime,
    required this.senderImage,
  });

  MessageEntity copyWith({
    int? id,
    String? senderId,
    String? receiverId,
    String? messageText,
    String? createTime,
    String? senderImage,
    bool? isReaded,
    String? senderName,
    String? image,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      messageText: messageText ?? this.messageText,
      createTime: createTime ?? this.createTime,
      senderImage: senderImage ?? this.senderImage,
      senderName: senderName ?? this.senderName,
      isReaded: isReaded ?? this.isReaded,
      type: type,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message_text': messageText,
      'create_time': createTime,
      'sender_image': senderImage,
      'is_readed': isReaded,
      'sender_name': senderName,
      'type': type.name,
      'image': image,
    };
  }

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'] as int?,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      messageText: json['message_text'] as String,
      createTime: json['create_time'] as String,
      senderImage: json['sender_image'] as String,
      senderName: json['sender_name'] as String,
      isReaded: json['is_readed'] as bool,
      type: getType(json['type'] as String),
      image: json['image'] as String?,
      chatId: json['chat_id'] as String?,
    );
  }
}

MessageType getType(String type) {
  if (type == MessageType.text.name) {
    return MessageType.text;
  } else {
    return MessageType.image;
  }
}
