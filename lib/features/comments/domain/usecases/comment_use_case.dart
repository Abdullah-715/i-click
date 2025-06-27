import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/comment_entity.dart';
import '../repository/comment_repo.dart';
import 'comment_base_use_case.dart';

class CommentUsecase implements CommentBaseUsecase {
  final CommentRepo repo;

  CommentUsecase({required this.repo});
  @override
  Future<Either<Failure, Unit>> addComment(
      {required CommentEntity comment, required String postId}) async {
    return await repo.addComment(comment: comment, postId: postId);
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      {required String postId}) async {
    return await repo.getComments(postId: postId);
  }
}
