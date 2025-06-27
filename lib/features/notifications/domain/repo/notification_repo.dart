import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/notification_entity.dart';

abstract class NotificationRepo {
  //? Repo for get all notifications:
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification();

  //? Repo for set notifications as readded :
  Future<Either<Failure, Unit>> setNotificationAsReadded();

  //? Repo for add notification :
  Future<Either<Failure, Unit>> addNotification(
      {required NotificationEntity notification});
}
