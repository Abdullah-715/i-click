import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/my_app.dart';
import '../../../../core/cubit/navigation_cubit/navigation_cubit.dart';
import 'package:toastification/toastification.dart';

class FirebaseApi {
  //? Create instanse for firebase messaging:
  final _firebaseMessaging = FirebaseMessaging.instance;
  BuildContext? context = Context.navKey.currentContext;

  //? Function to initialize notification:
  Future<void> initNotifications() async {
    //? Request presmission from user(will prompt user):
    await _firebaseMessaging.requestPermission();


    //? Init the function:
    //? TODO : This await added now :
    await initPushNotification();
  }

  //? Function to handle recived messaging:
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    if (kDebugMode) {
      print('message click!');
    }
   
    context!.read<NavigationCubit>().changeIndex(2);

  }

  //? Function to handle background settings:
  Future<void> initPushNotification() async {
    //? Handle notification if the app was terminated and now opened:
    _firebaseMessaging.getInitialMessage().then(handleMessage);

    //? attach event listener for when a notification opens the app:
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //? Handle notification in foreground:
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        toastification.show(
            showProgressBar: false,
            title: Text(message.notification!.title!),
            description: Text(message.notification!.body!),
            type: ToastificationType.info,
            style: ToastificationStyle.fillColored);
      }
    });
  }
}
