import 'package:dartz/dartz.dart';
import '../../../../core/supabase/supabase_get_methods.dart';
import '../../../../core/supabase/supabase_post_methods.dart';
import '../../domain/entity/comment_entity.dart';

abstract class CommentRemote {
  //? Remote for add comment :
  Future<Unit> addComment(
      {required CommentEntity comment, required String postId});

  //? Remote for get all comment :
  Future<List<CommentEntity>> getComments({required String postId});
}

class CommentRemoteImpl implements CommentRemote {
  @override
  Future<Unit> addComment(
      {required CommentEntity comment, required String postId}) {
    return SupabasePostMethods<Unit>()
        .add(body: comment.toJson(), table: 'comments', data: (_) => unit);
  }

  @override
  Future<List<CommentEntity>> getComments({required String postId}) {
    return SupabaseGetMethods<List<CommentEntity>>().getData(
        table: 'comments',
        order: 'create_time',
        data: (response) =>
            response.map((e) => CommentEntity.fromJson(e)).toList());
  }
}
