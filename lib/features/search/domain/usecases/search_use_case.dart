import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/search_entity.dart';
import '../repository/search_repo.dart';
import 'search_base_use_case.dart';

class SearchUseCase implements SearchBaseUseCase {
  final SearchRepo repo;

  SearchUseCase(this.repo);
  @override
  Future<Either<Failure, SearchEntity>> getSearch(
      {required String search}) async {
    return await repo.getSearch(search: search);
  }
}
