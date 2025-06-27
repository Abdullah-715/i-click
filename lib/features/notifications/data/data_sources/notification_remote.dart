import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/api/api_send_notification.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../domain/entity/notification_entity.dart';

abstract class NotificationRemote {
  //? Remoet for get all notifications :
  Future<List<NotificationEntity>> getAllNotifications();

  //? Remoet for set notifications as readded:
  Future<Unit> setNotificationsAsReadded();

  //? Remote for add notification:
  Future<Unit> addNotification({required NotificationEntity notification});

  //? Remote for update fcm :
  Future<Unit> updateFcm({required String userId});
}

class NotificationRemoteImpl implements NotificationRemote {
  @override
  Future<List<NotificationEntity>> getAllNotifications() {
    final query = {'user_id': AppSharedPref.getUserId()};
    return ApiGetMethods<List<NotificationEntity>>().get(
        url: ApiGet.getNotifications,
        query: query,
        data: (response) {
          final dataDecoded =
              jsonDecode(response.response!.body) as Map<String, dynamic>;
          final List data = dataDecoded['data'];
          return data.map((e) => NotificationEntity.fromJson(e)).toList();
        });
  }

  @override
  Future<Unit> setNotificationsAsReadded() {
    final body = {'user_id': AppSharedPref.getUserId()};
    return ApiPostMethods<Unit>().post(
        url: ApiPut.setNotificationsAsReaded, data: (_) => unit, body: body);
  }

  @override
  Future<Unit> addNotification({required NotificationEntity notification}) {
    if (notification.resciverId != AppSharedPref.getUserId()) {
      final body = {'notification_data': notification.toJson()};
      return ApiPostMethods<Unit>()
          .post(url: ApiPost.addNotification, data: (_) => unit, body: body)
          .then((_) async {
        await ApiSendNotification().sendNotification(
            type: notification.type!,
            name: notification.senderName!,
            userId: notification.resciverId!);

        return unit;
      });
    } else {
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> updateFcm({required String userId}) async {
    final body = {
      'user_id': userId,
      'new_token': await FirebaseMessaging.instance.getToken()
    };

    return ApiPostMethods<Unit>().post(
      url: ApiPut.updateFcm,
      data: (_) => unit,
      body: body,
    );
  }
}
