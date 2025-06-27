import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class AuthBaseUseCase {
  //? Base for login :
  Future<Either<Failure, String>> login(
      {required String email, required String password});

  //? Base for signUp :
  Future<Either<Failure, Unit>> signup(
      {required String userName,
      required String email,
      required String password});

  //? Base for confirm account :
  Future<Either<Failure, Unit>> verifiyEmail({required String accesToken});

  //? Base for reset password :
  Future<Either<Failure, Unit>> forgetPassword({
    required String password,
    required String accesToken,
  });

  //? Base for reset password :
  Future<Either<Failure, Unit>> changePassword({required String password});

  //? Base for reset password :
  Future<Either<Failure, Unit>> changeEmail({required String email});

  //? Base for logout :
  Future<Either<Failure, Unit>> logout();
}
