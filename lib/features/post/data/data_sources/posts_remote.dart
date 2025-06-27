import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/model/date_model.dart';
import '../../../../core/model/pagenation_model.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/supabase/supabase_storage.dart';
import '../../domain/entity/post_entity.dart';

abstract class PostsRemote {
  //?  Remote for add post :
  Future<Unit> addPost({required PostEntity post, required File file});

  //?  Remote for get single post :
  Future<PostEntity> getSingle({required String postId});

  //?  Remote for get all posts :
  Future<DataModel<List<PostEntity>>> getAllPosts(
      {required int start, required int limit});

  //?  Remote for delete post :
  Future<Unit> deletePost({required String postId, required String url});

  //?  Remote for update post :
  Future<Unit> updatePost({required PostEntity post});

  //?  Remote for like post :
  Future<PostEntity> likePost({required String postId, bool isLike = true});

  //?  Remote for update post :
  Future<String> addImageToPost({required File file, required String postId});
  //?  Remote for update post :
  Future<Unit> deleteImageFromPost({required String imageUrl});
}

class PostsRemoteImpl implements PostsRemote {
  @override
  Future<Unit> addPost({required PostEntity post, required File file}) async {
    final postAdded = PostEntity(
      postId: post.postId,
      postCreatorId: AppSharedPref.getUserId(),
      createTime: DateTime.now().toString(),
      description: post.description,
      postImageUrl: await addImageToPost(file: file, postId: post.postId!),
      postCreatorName: AppSharedPref.getUserName(),
      postCreatorImageUrl: AppSharedPref.getUserImage(),
      likes: [],
      comments: [],
    );
    final json = {"post_data": postAdded.toJson()};
    return ApiPostMethods<Unit>()
        .post(url: ApiPost.addPost, data: (_) => unit, body: json);
  }

  @override
  Future<DataModel<List<PostEntity>>> getAllPosts(
      {required int start, required int limit}) {
    
    return ApiGetMethods<DataModel<List<PostEntity>>>().get(
        url: ApiGet.getAllPosts,
        data: (response) {
          final dataDecoded =
              jsonDecode(response.response!.body) as Map<String, dynamic>;
          List postsDecoded = dataDecoded['data'];
          List<PostEntity> posts =
              postsDecoded.map((e) => PostEntity.fromJson(e)).toList();
          return DataModel(data: posts, pagenation: response.pagenation ?? PagenationModel());
        });
  }

  @override
  Future<String> addImageToPost({required File file, required String postId}) {
    return SupabaseStorage<String>().uploadFile(
        file: file, data: (url) => url, name: postId, bucket: 'posts_images');
  }

  @override
  Future<PostEntity> getSingle({required String postId}) {
    final query = {
      '_post_id': postId,
    };
    return ApiGetMethods<PostEntity>().get(
        query: query,
        url: ApiGet.getSinglePost,
        data: (response) {
          final data =
              jsonDecode(response.response!.body) as Map<String, dynamic>;
          final post = data['data'];

          return PostEntity.fromJson(post);
        });
  }

  @override
  Future<Unit> deletePost({required String postId, required String url}) {
    final json = {'post_id': postId};
    return ApiPostMethods<Unit>()
        .post(url: ApiDelete.deletePost, body: json, data: (_) => unit)
        .then((_) async {
      await deleteImageFromPost(imageUrl: url);
      return unit;
    });
  }

  @override
  Future<PostEntity> likePost(
      {required String postId, bool isLike = true}) async {
    final json = {'_post_id': postId, 'user_id': AppSharedPref.getUserId()};
    return ApiPostMethods<PostEntity>()
        .post(
            url: ApiPut.likePost,
            data: (response) {
              final dataDecoded = jsonDecode(response.body);
              return PostEntity.fromJson(dataDecoded['data']);
            },
            body: json)
        .then((post) async {
      if (post.likes!.contains(AppSharedPref.getUserId())) {
        await ApiSendNotification().sendNotification(
            type: NotificationType.likePost,
            name: post.postCreatorName!,
            userId: post.postCreatorId!);
      }

      return post;
    });
  }

  @override
  Future<Unit> updatePost({required PostEntity post}) {
    final json = {'post_data': post.toJson()};
    return ApiPostMethods<Unit>()
        .post(url: ApiPut.updatePost, data: (_) => unit, body: json);
  }

  @override
  Future<Unit> deleteImageFromPost({required String imageUrl}) async {
    return SupabaseStorage<Unit>().deleteImage(
        imageUrl: imageUrl, bucket: 'posts_images', data: (_) => unit);
  }
}
