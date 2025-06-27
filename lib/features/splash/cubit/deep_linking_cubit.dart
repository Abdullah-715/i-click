import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deep_linking_state.dart';

class DeepLinkingCubit extends Cubit<DeepLinkingState> {
  DeepLinkingCubit() : super(DeepLinkingState.init());

  void verifyAccount(String token) {
    emit(state.copyWith(status: DeepLinkingStatus.verify, token: token));
  }

  void resetPassword(String token) {
    emit(state.copyWith(status: DeepLinkingStatus.resetPassword, token: token));
  }

  void changeEmail(String token) {
    emit(state.copyWith(status: DeepLinkingStatus.changeEmail, token: token));
  }
}
