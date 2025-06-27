import 'package:dartz/dartz.dart';
import '../repo/core_repo.dart';
import 'core_base_use_case.dart';
import '../../error/failure.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

class CoreUseCase implements CoreBaseUseCase {
  final CoreRepo repo;

  CoreUseCase(this.repo);
  @override
  Future<Either<Failure, List<UserEntity>>> getUsersById(
      {required List<dynamic> ids}) async {
    return await repo.getUsersById(ids: ids);
  }
}
