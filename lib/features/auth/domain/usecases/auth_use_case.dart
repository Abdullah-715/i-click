import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../repository/auth_repo.dart';
import 'auth_base_use_case.dart';

class AuthUseCase implements AuthBaseUseCase {
  final AuthRepo repo;

  AuthUseCase(this.repo);

  @override
  Future<Either<Failure, Unit>> changeEmail({required String email}) async {
    return await repo.changeEmail(email: email);
  }

  @override
  Future<Either<Failure, Unit>> changePassword(
      {required String password}) async {
    return await repo.changePassword(password: password);
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(
      {required String password, required String accesToken}) async {
    return await repo.forgetPassword(
        password: password, accesToken: accesToken);
  }

  @override
  Future<Either<Failure, String>> login(
      {required String email, required String password}) async {
    return await repo.login(email: email, password: password);
  }

  @override
  Future<Either<Failure, Unit>> signup(
      {required String userName,
      required String email,
      required String password}) async {
    return await repo.signup(
        userName: userName, email: email, password: password);
  }

  @override
  Future<Either<Failure, Unit>> verifiyEmail(
      {required String accesToken}) async {
    return await repo.verifiyEmail(accesToken: accesToken);
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    return await repo.logout();
  }
}
