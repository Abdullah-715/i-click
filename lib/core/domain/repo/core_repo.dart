import 'package:dartz/dartz.dart';
import '../../error/failure.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

abstract class CoreRepo {
  //? Get users by id :
  Future<Either<Failure, List<UserEntity>>> getUsersById(
      {required List<dynamic> ids});
}
