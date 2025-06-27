import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/comment_entity.dart';

abstract class CommentBaseUsecase {
  //? Base for add comment :
  Future<Either<Failure, Unit>> addComment(
      {required CommentEntity comment, required String postId});

  //? Base for get all comments :
  Future<Either<Failure, List<CommentEntity>>> getComments(
      {required String postId});
}
