import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/notification_entity.dart';

abstract class NotificationBaseUsecase {
  //? Base for get all notifications:
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification();

  //? Base for set notifications as readded :
  Future<Either<Failure, Unit>> setNotificationAsReadded();

  //? Base for add notification :
  Future<Either<Failure, Unit>> addNotification(
      {required NotificationEntity notification});
}
