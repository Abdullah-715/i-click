import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_get.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../../../core/supabase/supabase_storage.dart';
import '../../../auth/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

abstract class ProfileRemote {
  //? Remote for profile data :
  Future<UserEntity> getProfileData({required String profileId});

  //? Remote for edit profile data :
  Future<Unit> updateProfile({required UserEntity user});

  //? Remote for add user image :
  Future<String> addUserImage(
      {required File file, required UserEntity user, required String oldUrl});

  //? Remote for follow profile :
  Future<UserEntity> followProfile({required String profileId});

  //? Remote for delete image :
  Future<Unit> deleteImage({String? url});
}

class ProfileRemoteImpl implements ProfileRemote {
  @override
  Future<UserEntity> getProfileData({required String profileId}) {
    return ApiGetMethods<UserEntity>().get(
        url: ApiGet.getProfileData,
        query: {'user_id': profileId},
        data: (response) {
          Map<String, dynamic> jsonDecoded =
              jsonDecode(response.response!.body);
          final user = UserEntity.fromJson(jsonDecoded['data']);
          if (profileId == AppSharedPref.getUserId()) {
            AppSharedPref.cacheUserImage(user.imageUrl ?? '');
            AppSharedPref.cacheUsername(user.name ?? '');
          }
          return user;
        });
  }

  @override
  Future<Unit> updateProfile({required UserEntity user}) {
    final body = {'json_data': user.toJson()};
    return ApiPostMethods<Unit>()
        .post(url: ApiPut.updateProfile, data: (_) => unit, body: body)
        .then((_) {
      AppSharedPref.cacheUsername(user.name ?? '');
      return unit;
    });
  }

  @override
  Future<String> addUserImage(
      {required File file,
      required UserEntity user,
      required String oldUrl}) async {
    final name = const Uuid().v1();
    return SupabaseStorage<String>()
        .uploadFile(
            file: file, data: (url) => url, name: name, bucket: 'users_images')
        .then((url) async {
      final userUpdated = user.copyWith(imageUrl: url);
      await updateProfile(user: userUpdated).then((_) async {
        await deleteImage(url: AppSharedPref.getUserImage());
        AppSharedPref.cacheUserImage(url);
        Logger().d('cached!' + url);
      });
      return url;
    });
  }

  @override
  Future<Unit> deleteImage({String? url}) {
    return SupabaseStorage<Unit>()
        .deleteImage(
      imageUrl: url ?? AppSharedPref.getUserImage() ?? '',
      bucket: 'users_images',
      data: (_) => unit,
    )
        .then((_) async {
      if (url == null) {
        final user = UserEntity(
          id: AppSharedPref.getUserId(),
          imageUrl: AppSharedPref.getUserId(),
        );
        await updateProfile(user: user);
        AppSharedPref.cacheUserImage(AppSharedPref.getUserId() ?? '');
      }
      return unit;
    });
  }

  @override
  Future<UserEntity> followProfile({required String profileId}) async {
    final body = {
      'my_user_id': AppSharedPref.getUserId(),
      'target_user_id': profileId,
    };

    return ApiPostMethods<UserEntity>().post(
        url: ApiPut.followProfile,
        data: (response) {
          Map<String, dynamic> dataDecoded = jsonDecode(response.body);
          return UserEntity.fromJson(dataDecoded);
        },
        body: body);
  }
}
