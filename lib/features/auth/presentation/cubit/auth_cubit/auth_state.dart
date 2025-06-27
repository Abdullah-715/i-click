part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final String id;

  const AuthState({
    required this.status,
    required this.id,
    required this.message,
  });

  factory AuthState.init() {
    return const AuthState(
      status: DeafultBlocStatus.initial,
      message: '',
      id: '',
    );
  }
  @override
  List<Object?> get props => [message, status, id];

  AuthState copyWith({
    DeafultBlocStatus? status,
    String? message,
    String? id,
  }) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
      id: id ?? this.id,
    );
  }
}
