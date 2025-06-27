import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/notification_entity.dart';
import '../repo/notification_repo.dart';
import 'notification_base_usecase.dart';

class NotificationUsecases implements NotificationBaseUsecase {
  final NotificationRepo repo;

  NotificationUsecases(this.repo);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() async {
    return await repo.getAllNotification();
  }

  @override
  Future<Either<Failure, Unit>> setNotificationAsReadded() async {
    return await repo.setNotificationAsReadded();
  }

  @override
  Future<Either<Failure, Unit>> addNotification(
      {required NotificationEntity notification}) async {
    return await repo.addNotification(notification: notification);
  }
}
