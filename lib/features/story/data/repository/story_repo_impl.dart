import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/check_net.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../remote/story_remote.dart';
import '../../domain/entity/story_entity.dart';
import '../../domain/repository/story_repo.dart';

class StoryRepoImpl implements StoryRepo {
  final StoryRemote remote;

  StoryRepoImpl({required this.remote});
  @override
  Future<Either<Failure, Unit>> addStory(
      {required StoryEntity story, required File file}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.addStory(story: story, file: file);
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllStories() {
    return CheckNet<List<UserEntity>>().checkNetResponse(tryRight: () async {
      final data = await remote.getAllStories();
      return Right(data);
    });
  }

  @override
  Future<Either<Failure, Unit>> showStory({required String storyId}) {
    return CheckNet<Unit>().checkNetResponse(tryRight: () async {
      final data = await remote.showStory(storyId: storyId);
      return Right(data);
    });
  }
}
