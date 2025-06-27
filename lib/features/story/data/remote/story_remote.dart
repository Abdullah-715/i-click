import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/supabase/supabase_storage.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../domain/entity/story_entity.dart';



abstract class StoryRemote {
  //* Remote add story :
  Future<Unit> addStory({required StoryEntity story, required File file});

  //* Remote for get all stories :
  Future<List<UserEntity>> getAllStories();

  //* Remote for add image to story :
  Future<String> addImageToStory({required File file, required String storyId});

  //* Remote for show story :
  Future<Unit> showStory({required String storyId});
}

class StoryRemoteImpl implements StoryRemote {
  @override
  Future<Unit> addStory(
      {required StoryEntity story, required File file}) async {
    final body = {
      'story_data': story.copyWith(
          imageUrl: await addImageToStory(file: file, storyId: story.storyId))
        ..toJson()
    };

    return ApiPostMethods<Unit>()
        .post(body: body, url: ApiPost.addStory, data: (_) => unit);
  }

  @override
  Future<List<UserEntity>> getAllStories() {
    final query = {'user_id': AppSharedPref.getUserId()};
    return ApiGetMethods<List<UserEntity>>().get(
        url: ApiGet.getStories,
        data: (response) {
          final dataDecoded =
              jsonDecode(response.response!.body) as Map<String, dynamic>;
          final data = dataDecoded['data'] as List<dynamic>;
          return data.map((e) => UserEntity.fromJson(e)).toList();
        },
        query: query);
  }

  @override
  Future<String> addImageToStory(
      {required File file, required String storyId}) {
    return SupabaseStorage<String>().uploadFile(
        file: file, data: (url) => url, bucket: 'story_images', name: storyId);
  }

  @override
  Future<Unit> showStory({required String storyId}) {
    //? My id :
    final id = AppSharedPref.getUserId();

    //? The body :
    final body = {
      'story_id': storyId,
      'viewer_id': id,
    };

    return ApiPostMethods<Unit>().post(
      url: ApiPost.showStory,
      data: (_) => unit,
      body: body,
    );
  }
}
