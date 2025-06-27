part of 'post_cubit.dart';

class PostState extends Equatable {
  final DeafultBlocStatus status;
  final String url;
  final String message;
  final List<PostEntity> posts;
  final PostEntity post;
  final PostEvent event;
  final File? imageFile;
  final bool isLike;
  final bool hasReachedMax;

  const PostState({
    this.imageFile,
    required this.event,
    required this.post,
    required this.posts,
    required this.hasReachedMax,
    required this.url,
    required this.status,
    required this.message,
    required this.isLike,
  });

  factory PostState.init() {
    return PostState(
        status: DeafultBlocStatus.initial,
        message: '',
        imageFile: null,
        url: '',
        posts: const [],
        post: PostEntity(),
        isLike: false,
        hasReachedMax: false,
        event: PostEvent.initial);
  }
  @override
  List<Object?> get props => [
        message,
        status,
        url,
        posts,
        post,
        event,
        imageFile,
        isLike,
        hasReachedMax,
      ];

  PostState copyWith({
    DeafultBlocStatus? status,
    String? message,
    String? url,
    List<PostEntity>? posts,
    PostEntity? post,
    PostEvent? event,
    File? imageFile,
    bool? isLike,
    bool? hasReachedMax,
  }) {
    return PostState(
        status: status ?? this.status,
        message: message ?? this.message,
        url: url ?? this.url,
        posts: posts ?? this.posts,
        post: post ?? this.post,
        event: event ?? this.event,
        imageFile: imageFile ?? this.imageFile,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLike: isLike ?? this.isLike);
  }
}
