part of 'profile_data_cubit.dart';

class ProfileState extends Equatable {
  final DeafultBlocStatus status;
  final String message;
  final UserEntity user;
  final String url;
  final ProfileEvent event;
  final File? file;
  final bool? isFollow;

  const ProfileState({
    this.file,
    this.isFollow,
    required this.event,
    required this.status,
    required this.message,
    required this.user,
    required this.url,
  });

  factory ProfileState.init() {
    return ProfileState(
      status: DeafultBlocStatus.initial,
      message: '',
      user: UserEntity(),
      url: '',
      event: ProfileEvent.initial,
      file: null,
      isFollow: null,
    );
  }
  @override
  List<Object?> get props => [message, status, user, url, event, file,isFollow];

  ProfileState copyWith({
    DeafultBlocStatus? status,
    String? message,
    UserEntity? user,
    String? url,
    ProfileEvent? event,
    File? file,
    bool? isFollow,
  }) {
    return ProfileState(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      url: url ?? this.url,
      event: event ?? this.event,
      file: file ?? this.file,
      isFollow: isFollow ?? this.isFollow,
    );
  }
}
