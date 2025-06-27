part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final List<NotificationEntity> notifications;
  final NotificationEvent event;

  const NotificationState({
    required this.event,
    required this.notifications,
    required this.status,
    required this.message,
  });

  factory NotificationState.init() {
    return const NotificationState(
        notifications: [],
        status: DeafultBlocStatus.initial,
        message: '',
        event: NotificationEvent.initial);
  }

  @override
  List<Object?> get props => [
        message,
        status,
        notifications,
        event,
      ];

  NotificationState copyWith({
    DeafultBlocStatus? status,
    String? message,
    List<NotificationEntity>? notifications,
    NotificationEvent? event,
  }) {
    return NotificationState(
        status: status ?? this.status,
        message: message ?? this.message,
        notifications: notifications ?? this.notifications,
        event: event ?? this.event);
  }
}
