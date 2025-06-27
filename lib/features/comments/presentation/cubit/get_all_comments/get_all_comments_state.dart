part of 'get_all_comments_cubit.dart';

class GetAllCommentsState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final List<CommentEntity> comments;

  const GetAllCommentsState({
    required this.status,
    required this.message,
    required this.comments,
  });

  factory GetAllCommentsState.init() {
    return const GetAllCommentsState(
      status: DeafultBlocStatus.initial,
      message: '',
      comments: [],
    );
  }
  @override
  List<Object?> get props => [message, status, comments];

  GetAllCommentsState copyWith({
    DeafultBlocStatus? status,
    String? message,
    List<CommentEntity>? comments,
  }) {
    return GetAllCommentsState(
      status: status ?? this.status,
      message: message ?? this.message,
      comments: comments ?? this.comments,
    );
  }
}
