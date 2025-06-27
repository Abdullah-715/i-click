import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../entity/story_entity.dart';

abstract class StoryRepo {
  //* Add story repo :
  Future<Either<Failure, Unit>> addStory(
      {required StoryEntity story, required File file});

  //* Get all stories repo :
  Future<Either<Failure, List<UserEntity>>> getAllStories();

  //* Show the story :
  Future<Either<Failure, Unit>> showStory({required String storyId});
}
