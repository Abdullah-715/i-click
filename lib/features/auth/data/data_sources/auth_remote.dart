import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../core/error/exception.dart';
import '../../../notifications/data/data_sources/notification_remote.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/api/api_links.dart';
import '../../../../core/api/api_methode_post.dart';
import '../../../../core/api/api_methode_put.dart';
import '../../../../core/shared/app_shared_prefrences.dart';
import '../../domain/entities/auth_entity/auth_entity.dart';
import '../../domain/entities/signup_entity/signup_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../../profile/data/data_sources/profile_remote.dart';

abstract class AuthRemote {
  //? Remote or login :
  Future<String> login({required String email, required String password});

  //? Remote for signup :
  Future<Unit> signup(
      {required String email, required String password, required String name});

  //? Remote for create account :
  Future<Unit> verifiyEmail({required String accesToken});

  //? Remote for forget password :
  Future<Unit> forgetPassword(
      {required String password, required String accesToken});

  //? Remote for change password :
  Future<Unit> changePassword({required String password});

  //? Remote for change email :
  Future<Unit> changeEmail({required String email});

  //? Remote for logout :
  Future<Unit> logout();
}

class AuthRemoteImpl implements AuthRemote {
  @override
  Future<String> login({required String email, required String password}) {
    final json = {'email': email, 'password': password};
    return ApiPostMethods<String>()
        .post(
            isAuth: true,
            url: ApiPost.login,
            body: json,
            data: (response) {
              //?? Get json data:
              final data = jsonDecode(response.body) as Map<String, dynamic>;

              //?? Parse it :
              final authEntity = AuthEntity.fromJson(data);

              //?? Check if confirmed :
              //? if (authEntity.user?.emailConfirmedAt != null) {
              //?? Cache the token :
              AppSharedPref.cacheToken(authEntity.accessToken ?? '');

              //?? Cache the id :
              AppSharedPref.cacheId(authEntity.user?.id ?? '');
              return authEntity.user!.id!;
            })
        .then((id) async {
      //? try {
      await NotificationRemoteImpl().updateFcm(userId: id);
      await ProfileRemoteImpl().getProfileData(profileId: id);
      //? } catch (_) {}
      return id;
    });
  }

  @override
  Future<Unit> signup({
    required String email,
    required String password,
    required String name,
  }) {
    final json = {'email': email, 'password': password};
    late String id;
    return ApiPostMethods<Unit>()
        .post(
            isAuth: true,
            url: ApiPost.signup,
            body: json,
            data: (response) {
              //?? Get json data:
              final data = jsonDecode(response.body) as Map<String, dynamic>;

              //?? Parse it :
              final authEntity = SignupEntity.fromJson(data);

              //?? Impl the id :
              id = authEntity.id!;
              AppSharedPref.cacheEmail(email);

              return unit;
            })
        .then((h) async {
      try {
        await createUser(
          email: email,
          password: password,
          name: name,
          id: id,
        );
        //?TODO :
      } catch (_) {}
      return h;
    });
  }

  Future<Unit> createUser({
    required String email,
    required String password,
    required String name,
    required String id,
  }) async {
    //?? Create user :
    final user = UserEntity(
      id: id,
      bio: '',
      displayName: name,
      email: email,
      password: password,
      imageUrl: id,
      name: name,
      fcmToken: [await FirebaseMessaging.instance.getToken() ?? ''],
      followers: [],
      followings: [],
    );

    //?? Create body :
    final json = {'user_data': user.toJson()};

    return ApiPostMethods<Unit>().post(
        url: ApiPost.createUser, isAuth: true, body: json, data: (_) => unit);
  }

  @override
  Future<Unit> forgetPassword(
      {required String password, required String accesToken}) {
    //?? The headers :
    final headers = {'Authorization': 'Bearer $accesToken'};

    //?? The body :
    final body = {'password': password};
    return ApiPutMethods<Unit>(addHeader: headers).put(
      url: ApiPut.changeEmail,
      data: (_) => unit,
      body: body,
    );
  }

  @override
  Future<Unit> changeEmail({required String email}) {
    //?? Get the token :
    final token = AppSharedPref.getUserToken();

    //?? Add to header :
    final json = {'Authorization': 'Bearer $token'};

    //?? The body :
    final body = {'email': email};

    return ApiPutMethods<Unit>(addHeader: json).put(
      url: ApiPut.changeEmail,
      data: (_) => unit,
      body: body,
    );
  }

  @override
  Future<Unit> changePassword({required String password}) {
    final token = AppSharedPref.getUserToken();

    //?? Add to header :
    final headers = {'Authorization': 'Bearer $token'};

    //?? The body :
    final body = {'password': password};

    return ApiPutMethods<Unit>(addHeader: headers).put(
      url: ApiPut.changeEmail,
      data: (_) => unit,
      body: body,
    );
  }

  @override
  Future<Unit> verifiyEmail({required String accesToken}) async {
    final supabase = Supabase.instance.client;
    //?? The headers :

    try {
      Logger().e('email:${AppSharedPref.getUserEmail()!} \n token:$accesToken');
      await supabase.auth.verifyOTP(
        token: accesToken,
        type: OtpType.email,
        email: AppSharedPref.getUserEmail(),
      );
      return unit;
    
    } catch (e) {
      Logger().e(e.toString());
      throw ServerException(e.toString());
    }
    
  }

  @override
  Future<Unit> logout() async {
    final body = {
      'user_id': AppSharedPref.getUserId(),
      'token_to_remove': await FirebaseMessaging.instance.getToken()
    };

    return ApiPostMethods<Unit>().post(
      url: ApiPost.logout,
      data: (_) => unit,
      body: body,
    );
  }
}
