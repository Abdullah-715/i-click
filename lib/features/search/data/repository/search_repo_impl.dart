import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_source/search_remote_data_source.dart';
import '../../domain/entity/search_entity.dart';
import '../../domain/repository/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource remote;

  SearchRepoImpl(this.remote);
  @override
  Future<Either<Failure, SearchEntity>> getSearch({required String search}) {
    return CheckNet<SearchEntity>().checkNetResponse(tryRight: () async {
      final data = await remote.getSearch(search: search);
      return Right(data);
    });
  }
}
