import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/entity/notification_entity.dart';
import '../../../domain/usecases/notification_base_usecase.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.usecase) : super(NotificationState.init());

  final NotificationBaseUsecase usecase;

  //* For get all notifications :
  Future<void> getAllNotifications() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: NotificationEvent.getAllNotifications,
    ));

    final data = await usecase.getAllNotification();

    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (notifications) => emit(state.copyWith(
          status: DeafultBlocStatus.done, notifications: notifications)),
    );
  }
  //*

  //* For set notifications as readded :
  Future<void> setNotificatiosAsReadded() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: NotificationEvent.setNotificationsAsReaded,
    ));

    final data = await usecase.setNotificationAsReadded();

    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (_) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }
  //*

  //* For add notification :
  Future<void> addNotification(
      {required NotificationEntity notification}) async {
    emit(state.copyWith(
        status: DeafultBlocStatus.loading,
        event: NotificationEvent.addNotification));

    final data = await usecase.addNotification(notification: notification);

    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (_) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }
  //*
}
