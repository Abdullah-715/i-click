import 'package:dartz/dartz.dart';
import '../remote/core_remote.dart';
import '../../domain/repo/core_repo.dart';
import '../../error/failure.dart';
import '../../network/check_net.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

class CoreRepoImpl implements CoreRepo {
  final CoreRemote remote;

  CoreRepoImpl(this.remote);
  @override
  Future<Either<Failure, List<UserEntity>>> getUsersById(
      {required List<dynamic> ids}) {
    return CheckNet<List<UserEntity>>().checkNetResponse(tryRight: () async {
      final data = await remote.getUsersByIds(ids);
      return Right(data);
    });
  }
}
