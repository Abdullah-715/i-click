import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/core_base_use_case.dart';
import '../../resources/enum_manger.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

part 'short_users_state.dart';

class ShortUsersCubit extends Cubit<ShortUsersState> {
  ShortUsersCubit(this.usecase) : super(ShortUsersState.init());

  final CoreBaseUseCase usecase;

  //* Get users :
  Future<void> getUsersById({required List<dynamic> ids}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));
    final data = await usecase.getUsersById(ids: ids);
    data.fold(
      (failure) => emit(state.copyWith(status: DeafultBlocStatus.error)),
      (users) =>
          emit(state.copyWith(status: DeafultBlocStatus.done, users: users)),
    );
  }
  //*
}
