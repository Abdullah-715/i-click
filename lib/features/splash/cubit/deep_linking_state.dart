// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deep_linking_cubit.dart';

enum DeepLinkingStatus {
  initial,
  verify,
  resetPassword,
  changeEmail,
}

class DeepLinkingState extends Equatable {
  const DeepLinkingState({
    required this.token,
    required this.status,
  });

  final String token;
  final DeepLinkingStatus status;

  @override
  List<Object> get props => [token, status];

  factory DeepLinkingState.init() {
    return const DeepLinkingState(
      token: '',
      status: DeepLinkingStatus.initial,
    );
  }

  DeepLinkingState copyWith({
    String? token,
    DeepLinkingStatus? status,
  }) {
    return DeepLinkingState(
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }
}
