import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:i_click_app/core/api/api_get_server_key_fcm.dart';
import 'package:i_click_app/core/api/api_links.dart';
import 'package:i_click_app/core/api/api_methode_get.dart';
import 'package:i_click_app/core/error/exception.dart';
import 'package:i_click_app/core/model/notification_model.dart';
import 'package:logger/logger.dart';

enum NotificationType {
  follow('follow'),
  comment('comment'),
  message('message'),
  likePost('likePost');

  final String name;

  const NotificationType(this.name);
}

class ApiSendNotification {
  Future<String> getUserToken(String id) async {
    final query = {'user_id': id};

    return ApiGetMethods<String>().get(
        url: ApiGet.getUserToken,
        data: (response ) {
          final dataDecoded = jsonDecode(response.response!.body);
          final token = dataDecoded['data']['fcm_token'];
          return token;
        },
        query: query);
  }

  Future<void> sendNotification({
    required NotificationType type,
    required String name,
    required String userId,
    String? msg,
  }) async {
    try {
      //? init the notification :

      final notification = NotificationMessageModel(
          token: await getUserToken(userId),
          notification: Notification(
            title: msg != null ? name : 'new notification',
            body: type == NotificationType.likePost
                ? '$name has like your post'
                : type == NotificationType.follow
                    ? '$name has started follow you'
                    : type == NotificationType.message
                        ? msg ?? ''
                        : '$name has commented on your post',
          ),
          data: null);

      //? get the fcm token :
      final token = await ApiGetServerKey().getServerKey();

      //? add the headers :
      final header = {'Authorization': 'Bearer $token}'};

      //? create the response :
      await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/supabase-56b6d/messages:send'),
        headers: header,
        body: notification.toJson(),
      );
    } catch (e) {
      Logger().d(e);
      throw ServerException(e.toString());
    }
  }
}
