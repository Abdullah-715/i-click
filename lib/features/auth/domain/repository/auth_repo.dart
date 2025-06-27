import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class AuthRepo {
  //? Repo for login :
  Future<Either<Failure, String>> login(
      {required String email, required String password});

  //? Repo for signUp :
  Future<Either<Failure, Unit>> signup(
      {required String userName,
      required String email,
      required String password});

  //? Repo for confirm account :
  Future<Either<Failure, Unit>> verifiyEmail({required String accesToken});

  //? Repo for reset password :
  Future<Either<Failure, Unit>> forgetPassword({
    required String password,
    required String accesToken,
  });

  //? Repo for reset password :
  Future<Either<Failure, Unit>> changePassword({required String password});

  //? Repo for reset password :
  Future<Either<Failure, Unit>> changeEmail({required String email});

  //? Repo for logout :
  Future<Either<Failure, Unit>> logout();
}
