import 'dart:convert';

import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../domain/entity/search_entity.dart';

abstract class SearchRemoteDataSource {
  //? Remote for get search :
  Future<SearchEntity> getSearch({required String search});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  @override
  Future<SearchEntity> getSearch({required String search}) {
    final query = {
      'search_text': search,
    };
    return ApiGetMethods<SearchEntity>().get(
        url: ApiGet.getSearch,
        data: (response) {
          final dataDecoded = jsonDecode(response.response!.body) as Map<String, dynamic>;
          SearchEntity searchEntity = SearchEntity.fromJson(dataDecoded['data']);
          return searchEntity;
        },
        query: query);
  }
}
