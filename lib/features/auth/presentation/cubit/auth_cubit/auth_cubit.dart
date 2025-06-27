import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/usecases/auth_base_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.usecae) : super(AuthState.init());
  final AuthBaseUseCase usecae;

  //* Login Cubit :
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.login(email: email, password: password);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (id) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
        id: id,
      )),
    );
  }
  //*

  //* Logout Cubit :
  Future<void> logout() async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.logout();
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (unit) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }
  //*

  //* Signup Cubit :
  Future<void> signup(
      {required String userName,
      required String email,
      required String password}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.signup(
        userName: userName, email: email, password: password);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
      )),
    );
  }
  //*

  //* Verify Email Cubit :
  Future<void> verifiyEmail({required String accesToken}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.verifiyEmail(accesToken: accesToken);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
      )),
    );
  }
  //*

  //* Forget Password Cubit :
  Future<void> forgetPassword({
    required String password,
    required String accesToken,
  }) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase =
        await usecae.forgetPassword(password: password, accesToken: accesToken);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
      )),
    );
  }
  //*

  //* Change Password Cubit :
  Future<void> changePassword({required String password}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.changePassword(password: password);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
      )),
    );
  }
  //*

  //* Change Email Cubit :
  Future<void> changeEmail({required String email}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    final supabase = await usecae.changeEmail(email: email);
    supabase.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
      )),
    );
  }
  //*
}
