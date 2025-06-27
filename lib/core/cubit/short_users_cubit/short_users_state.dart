part of 'short_users_cubit.dart';

class ShortUsersState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final List<UserEntity> users;

  const ShortUsersState({
    required this.status,
    required this.users,
    required this.message,
  });

  factory ShortUsersState.init() {
    return const ShortUsersState(
      status: DeafultBlocStatus.initial,
      message: '',
      users: [],
    );
  }
  @override
  List<Object?> get props => [message, status, users];

  ShortUsersState copyWith({
    DeafultBlocStatus? status,
    String? message,
    List<UserEntity>? users,
  }) {
    return ShortUsersState(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }
}
