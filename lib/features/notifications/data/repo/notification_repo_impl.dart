import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_sources/notification_remote.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationRemote remote;

  NotificationRepoImpl(this.remote);

  @override
  Future<Either<Failure, Unit>> addNotification(
      {required NotificationEntity notification}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.addNotification(notification: notification);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getAllNotification() {
    return CheckNet<List<NotificationEntity>>().checkNetResponse(
        tryRight: () async {
      final data = await remote.getAllNotifications();
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> setNotificationAsReadded() {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.setNotificationsAsReadded();
      return Right(data);
    });
  }
}
