import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_sources/comment_remote.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/repository/comment_repo.dart';

class CommentRepoImpl implements CommentRepo {
  final CommentRemote remote;

  CommentRepoImpl(this.remote);
  @override
  Future<Either<Failure, Unit>> addComment(
      {required CommentEntity comment, required String postId}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.addComment(comment: comment, postId: postId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      {required String postId}) {
    return CheckNet<List<CommentEntity>>().checkNetResponse(tryRight: () async {
      final data = await remote.getComments(postId: postId);
      return Right(data);
    });
  }
}
