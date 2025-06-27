part of 'story_cubit_cubit.dart';

class StoryState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final List<UserEntity?> stories;
  final File? file;
  final StoryEvent event;

  const StoryState(
    this.file, {
    required this.event,
    required this.stories,
    required this.status,
    required this.message,
  });

  factory StoryState.init() {
    return const StoryState(
      null,
      event: StoryEvent.initial,
      stories: [],
      status: DeafultBlocStatus.initial,
      message: '',
    );
  }
  @override
  List<Object?> get props => [message, status, file, stories, event];

  StoryState copyWith({
    DeafultBlocStatus? status,
    String? message,
    List<UserEntity?>? stories,
    File? file,
    StoryEvent? event,
  }) {
    return StoryState(
      file ?? this.file,
      status: status ?? this.status,
      message: message ?? this.message,
      stories: stories ?? this.stories,
      event: event ?? this.event,
    );
  }
}
