part of 'add_comment_cubit.dart';

class AddCommentState extends Equatable {
  final DeafultBlocStatus status;
  final String message;

  const AddCommentState({
    required this.status,
    required this.message,
  });

  factory AddCommentState.init() {
    return const AddCommentState(
      status: DeafultBlocStatus.initial,
      message: '',
    );
  }
  @override
  List<Object?> get props => [message, status];

  AddCommentState copyWith({
    DeafultBlocStatus? status,
    String? message,
  }) {
    return AddCommentState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
