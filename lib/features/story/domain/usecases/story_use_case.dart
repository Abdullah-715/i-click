import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entity/story_entity.dart';
import '../repository/story_repo.dart';
import 'story_base_use_case.dart';

class StoryUsecase implements StoryBaseUsecase {
  final StoryRepo repo;

  StoryUsecase({required this.repo});

  @override
  Future<Either<Failure, Unit>> addStory(
      {required StoryEntity story, required File file}) async {
    return await repo.addStory(story: story, file: file);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllStories() async {
    return await repo.getAllStories();
  }

  @override
  Future<Either<Failure, Unit>> showStory({required String storyId}) async {
    return await repo.showStory(storyId: storyId);
  }
}
