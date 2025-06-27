import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/model/date_model.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../data_sources/posts_remote.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/posts_repo.dart';

class PostsRepoImpl implements PostsRepo {
  final PostsRemote remote;

  PostsRepoImpl(this.remote);
  @override
  Future<Either<Failure, Unit>> addPost(
      {required PostEntity post, required File file}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.addPost(post: post, file: file);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(
      {required String postId, required String url}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.deletePost(postId: postId, url: url);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure,DataModel<List<PostEntity>>>> getAllPosts(
      {required int start, required int limit}) {
    return CheckNet<DataModel<List<PostEntity>>>().checkNetResponse(tryRight: () async {
      final data = await remote.getAllPosts(start: start,limit: limit);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, PostEntity>> likePost(
      {required String postId, bool isLike = true}) {
    return CheckNet<PostEntity>().checkNetResponse(tryRight: () async {
      final data = await remote.likePost(postId: postId, isLike: isLike);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost({required PostEntity post}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.updatePost(post: post);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, String>> addImageToPost(
      {required File file, required String postId}) {
    return CheckNet<String>().checkNetResponse(tryRight: () async {
      final data = await remote.addImageToPost(file: file, postId: postId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, PostEntity>> getSinglePosts({required String postId}) {
    return CheckNet<PostEntity>().checkNetResponse(tryRight: () async {
      final data = await remote.getSingle(postId: postId);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteImageFromPost(
      {required String imageUrl}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.deleteImageFromPost(imageUrl: imageUrl);
      return Right(data);
    });
  }
}
