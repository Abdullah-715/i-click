import 'dart:convert';

class NotificationMessageModel {
  final String? token;
  final Notification notification;
  final dynamic data;

  NotificationMessageModel({
    required this.token,
    required this.notification,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': {
        'token': token,
        'notification': notification.toMap(),
        'data': data,
      }
    };
  }

  String toJson() => json.encode(toMap());
}

class Notification {
  final String title;
  final String body;

  Notification({
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
    };
  }

  String toJson() => json.encode(toMap());
}
