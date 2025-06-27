import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_sources/auth_remote.dart';
import '../../domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemote remote;

  AuthRepoImpl({required this.remote});

  @override
  Future<Either<Failure, Unit>> changeEmail({required String email}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.changeEmail(email: email);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> changePassword({required String password}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.changePassword(password: password);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(
      {required String password, required String accesToken}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.forgetPassword(
          password: password, accesToken: accesToken);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, String>> login(
      {required String email, required String password}) {
    return CheckNet<String>().checkNetResponse(tryRight: () async {
      final data = await remote.login(email: email, password: password);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> signup(
      {required String userName,
      required String email,
      required String password}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data =
          await remote.signup(email: email, password: password, name: userName);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> verifiyEmail({required String accesToken}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.verifiyEmail(accesToken: accesToken);
      return Right(data);
    });
  }
  
  @override
  Future<Either<Failure, Unit>> logout() {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.logout();
      return Right(data);
    });
  }
}
