import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../data_sources/profile_remote.dart';
import '../../domain/repository/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemote remote;

  ProfileRepoImpl(this.remote);
  @override
  Future<Either<Failure, UserEntity>> getProfiledata(
      {required String profileId}) {
    return CheckNet<UserEntity>().checkNetResponse(tryRight: () async {
      final data = await remote.getProfileData(profileId: profileId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProfile({required UserEntity user}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.updateProfile(user: user);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, String>> addUserImage(
      {required File file, required UserEntity user, required String oldUrl}) {
    return CheckNet<String>().checkNetResponse(tryRight: () async {
      final data =
          await remote.addUserImage(file: file, user: user, oldUrl: oldUrl);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, UserEntity>> followProfile(
      {required String profileId}) {
    return CheckNet<UserEntity>().checkNetResponse(tryRight: () async {
      final data = await remote.followProfile(profileId: profileId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProfileImage() {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.deleteImage();
      return Right(data);
    });
  }
}
