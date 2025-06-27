import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/image_picker.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../../../core/shared/app_shared_prefrences.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/usecases/profile_base_use_case.dart';

part 'profile_data_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.usecase) : super(ProfileState.init());

  final ProfileBaseUsecase usecase;

  //* For get profile data :
  Future<void> getProfileData(
      {required String profileId, bool isFirst = true}) async {
    emit(state.copyWith(event: ProfileEvent.getProfile));
    if (isFirst) {
      emit(state.copyWith(status: DeafultBlocStatus.loading));
    }
    final data = await usecase.getProfiledata(profileId: profileId);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (user) =>
          emit(state.copyWith(status: DeafultBlocStatus.done, user: user)),
    );
  }
  //*

  //* For add image to profile :
  Future<void> addImage({required UserEntity user}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ProfileEvent.addImage,
    ));
    if (state.file != null) {
      final data = await usecase.addUserImage(
          file: state.file!, user: user, oldUrl: user.imageUrl ?? '');
      data.fold(
        (failure) => emit(state.copyWith(
            status: DeafultBlocStatus.error, message: mapFailure(failure))),
        (url) => emit(state.copyWith(status: DeafultBlocStatus.done, url: url)),
      );
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done));
    }
  }

  //* For edit profile :
  Future<void> updateProfile({required UserEntity user}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ProfileEvent.updateProfile,
    ));
    final data = await usecase.updateProfile(user: user);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) {
        AppSharedPref.cacheUserImage(user.imageUrl ?? '');
        AppSharedPref.cacheUsername(user.name!);
        emit(state.copyWith(status: DeafultBlocStatus.done));
      },
    );
  }
  //*

  //* For edit profile :
  Future<void> deleteImage() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: ProfileEvent.deleteImage,
    ));
    final data = await usecase.deleteProfileImage();
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(
          state.copyWith(status: DeafultBlocStatus.done, url: state.user.id)),
    );
  }

  //*
  //* Select picture :
  Future<void> picImage() async {
    emit(state.copyWith(
      event: ProfileEvent.pickImage,
    ));
    final file = await pickImage();
    if (file != null) {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: file));
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: null));
    }
  }
  //*

  //* For follow user :
  Future<void> followProfile(
      {required String profileId, bool isFirst = true}) async {
    emit(state.copyWith(event: ProfileEvent.follow));

    if (isFirst) {
      emit(state.copyWith(status: DeafultBlocStatus.loading));
    }
    final data = await usecase.followProfile(profileId: profileId);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (user) {
        emit(state.copyWith(status: DeafultBlocStatus.done));
        getProfileData(profileId: profileId, isFirst: false);
      },
    );
  }
  //*

  //* for follow button :
  void changeFollow(bool isFollow) {
    emit(state.copyWith(event: ProfileEvent.changeFollow, isFollow: !isFollow));
  }
}
