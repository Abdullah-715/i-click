import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../repository/profile_repo.dart';
import 'profile_base_use_case.dart';

class ProfileUsecase implements ProfileBaseUsecase {
  final ProfileRepo repo;

  ProfileUsecase(this.repo);
  @override
  Future<Either<Failure, UserEntity>> getProfiledata(
      {required String profileId}) async {
    return await repo.getProfiledata(profileId: profileId);
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(
      {required UserEntity user}) async {
    return await repo.updateProfile(user: user);
  }

  @override
  Future<Either<Failure, String>> addUserImage(
      {required File file,
      required UserEntity user,
      required String oldUrl}) async {
    return await repo.addUserImage(file: file, user: user, oldUrl: oldUrl);
  }

  @override
  Future<Either<Failure, UserEntity>> followProfile(
      {required String profileId}) async {
    return await repo.followProfile(profileId: profileId);
  }

  @override
  Future<Either<Failure, Unit>> deleteProfileImage() async {
    return await repo.deleteProfileImage();
  }
}
