import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';

abstract class ProfileBaseUsecase {
  //? Base for profile data :
  Future<Either<Failure, UserEntity>> getProfiledata(
      {required String profileId});

  //? Base for edit profile data :
  Future<Either<Failure, Unit>> updateProfile({required UserEntity user});

  //? Base for add image to user :
  Future<Either<Failure, String>> addUserImage(
      {required File file, required UserEntity user, required String oldUrl});

  //? Base for follow profile to user :
  Future<Either<Failure, UserEntity>> followProfile(
      {required String profileId});

  //? Base for delete profile image :
  Future<Either<Failure, Unit>> deleteProfileImage();
}
