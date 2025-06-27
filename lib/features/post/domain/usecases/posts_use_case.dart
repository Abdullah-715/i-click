import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/model/date_model.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';
import '../repository/posts_repo.dart';
import 'posts_base_use_case.dart';

class PostsUseCase implements PostsBaseUseCase {
  final PostsRepo repo;

  PostsUseCase(this.repo);
  @override
  Future<Either<Failure, Unit>> addPost(
      {required PostEntity post, required File file}) async {
    return await repo.addPost(post: post, file: file);
  }

  @override
  Future<Either<Failure, Unit>> deletePost(
      {required String postId, required String url}) async {
    return await repo.deletePost(postId: postId, url: url);
  }

  @override
  Future<Either<Failure,DataModel<List<PostEntity>>>> getAllPosts(
      {required int start, required int limit}) async {
    return await repo.getAllPosts(start:start,limit:limit);
  }

  @override
  Future<Either<Failure, PostEntity>> getSinglePosts(
      {required String postId}) async {
    return await repo.getSinglePosts(postId: postId);
  }

  @override
  Future<Either<Failure, PostEntity>> likePost(
      {required String postId, bool isLike = true}) async {
    return await repo.likePost(postId: postId, isLike: isLike);
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required PostEntity post}) async {
    return await repo.updatePost(post: post);
  }

  @override
  Future<Either<Failure, String>> addImageToPost(
      {required File file, required String postId}) async {
    return await repo.addImageToPost(file: file, postId: postId);
  }

  @override
  Future<Either<Failure, Unit>> deleteImageFromPost(
      {required String imageUrl}) async {
    return await repo.deleteImageFromPost(imageUrl: imageUrl);
  }
}
