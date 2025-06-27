import '../../../../core/api/api_send_notification.dart';

class NotificationEntity {
  final String? id;
  final String? senderName;
  final String? resciverId;
  final String? senderId;
  final String? createTime;
  final String? senderImageUrl;
  final NotificationType? type;
  final String? title;
  final String? postImage;
  final String? data;
  final bool? isReadded;

  

  NotificationEntity(
      {this.id,
      this.postImage,
      this.isReadded,
      this.resciverId,
      this.senderName,
      this.senderImageUrl,
      this.type,
      this.createTime,
      this.senderId,
      this.title,
      this.data});

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
        id: json['id'],
        createTime: json['create_time'],
        senderName: json['notification_sender_name'],
        senderImageUrl: json['notification_sender_image_url'],
        type: getType(json['type'] as String),
        title: json['notification_title'],
        postImage: json['post_image_url'],
        resciverId: json['notification_reciver_id'],
        data: json['data'],
        senderId: json['notification_sender_id'],
        isReadded: json['is_readed']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'create_time': createTime,
      'notification_sender_name': senderName,
      'notification_sender_image_url': senderImageUrl,
      'type': type?.name,
      'notification_title': title,
      'post_image_url': postImage,
      'data': data,
      'notification_reciver_id': resciverId,
      'is_readed': isReadded,
      'notification_sender_id': senderId
    };
  }
}

NotificationType getType(String type) {
  if (type == NotificationType.comment.name) {
    return NotificationType.comment;
  } else if (type == NotificationType.follow.name) {
    return NotificationType.follow;
  } else {
    return NotificationType.likePost;
  }
}
