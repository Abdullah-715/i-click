import 'dart:convert';

import '../../api/api_links.dart';
import '../../api/api_methode_get.dart';
import '../../../features/auth/domain/entities/user_entity.dart';

abstract class CoreRemote {
  //? Get usres by ids :
  Future<List<UserEntity>> getUsersByIds(List<dynamic> ids);
}

class CoreRemoteImpl implements CoreRemote {
  @override
  Future<List<UserEntity>> getUsersByIds(List<dynamic> ids) {
    final textIds = ids.join(',');
    final query = {'user_ids_text': textIds};
    return ApiGetMethods<List<UserEntity>>().get(
      url: ApiGet.getUsersByIds,
      data: (response) {
        final dataDecoded = jsonDecode(response.response!.body);
        List postsDecoded = dataDecoded['data'];
        return postsDecoded.map((e) => UserEntity.fromJson(e)).toList();
      },
      query: query,
    );
  }
}
