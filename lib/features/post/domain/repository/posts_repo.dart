import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/model/date_model.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';

abstract class PostsRepo {
  //?  Repo for get all posts :
  Future<Either<Failure,DataModel<List<PostEntity>>>> getAllPosts(
      {required int start, required int limit});

  //?  Repo for get single post :
  Future<Either<Failure, PostEntity>> getSinglePosts({required String postId});

  //?  Repo for add post :
  Future<Either<Failure, Unit>> addPost(
      {required PostEntity post, required File file});

  //?  Repo for delete post :
  Future<Either<Failure, Unit>> deletePost(
      {required String postId, required String url});

  //?  Repo for update post :
  Future<Either<Failure, Unit>> updatePost({required PostEntity post});

  //?  Repo for like post :
  Future<Either<Failure, PostEntity>> likePost(
      {required String postId, bool isLike = true});

  //?  Repo for add image to post :
  Future<Either<Failure, String>> addImageToPost(
      {required File file, required String postId});

  //?  Repo for delte image to post :
  Future<Either<Failure, Unit>> deleteImageFromPost({required String imageUrl});
}
