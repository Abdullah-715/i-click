import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/search_entity.dart';

abstract class SearchRepo {
  //? Repo for get search:
  Future<Either<Failure, SearchEntity>> getSearch({required String search});
}
