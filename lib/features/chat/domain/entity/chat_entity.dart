import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String? id;
  final bool? isReaded;
  final String? firstUserId;
  final String? secondUserId;
  final String? firstUserName;
  final String? secondUserName;
  final String? firstUserImage;
  final String? lastMessageText;
  final String? secondUserImage;
  final String? lastMessageCreateTime;
  final int? firstUserCount;
  final int? secondUserCount;

  const ChatEntity({
    this.id,
    this.firstUserCount,
    this.secondUserCount,
    this.isReaded,
    this.firstUserId,
    this.secondUserId,
    this.firstUserImage,
    this.lastMessageText,
    this.secondUserImage,
    this.lastMessageCreateTime,
    this.firstUserName,
    this.secondUserName,
  });

  factory ChatEntity.fromJson(Map<String, dynamic> json) => ChatEntity(
        id: json['id'] as String?,
        isReaded: json['is_readed'] as bool?,
        firstUserId: json['first_user_id'] as String?,
        secondUserId: json['second_user_id'] as String?,
        firstUserName: json['first_user_name'] as String?,
        secondUserName: json['second_user_name'] as String?,
        firstUserImage: json['first_user_image'] as String?,
        firstUserCount: json['first_user_count'] as int?,
        secondUserCount: json['second_user_count'] as int?,
        lastMessageText: json['last_message_text'] as String?,
        secondUserImage: json['second_user_image'] as String?,
        lastMessageCreateTime: json['last_message_create_time'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'is_readed': isReaded,
        'first_user_id': firstUserId,
        'second_user_id': secondUserId,
        'first_user_name': firstUserName,
        'second_user_name': secondUserName,
        'first_user_image': firstUserImage,
        'last_message_text': lastMessageText,
        'second_user_image': secondUserImage,
        'last_message_create_time': lastMessageCreateTime,
      };

  @override
  List<Object?> get props {
    return [
      id,
      isReaded,
      firstUserId,
      secondUserId,
      firstUserImage,
      lastMessageText,
      secondUserImage,
      lastMessageCreateTime,
    ];
  }
}
