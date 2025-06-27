import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../error/exception.dart';
import '../shared/app_shared_prefrences.dart';
import 'supabase_get_methods.dart';
import 'supabase_post_methods.dart';
import '../../features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthMethods<T> {
  final supabase = Supabase.instance.client;

  //?Login :
  Future<T> login({
    required String email,
    required String password,
    required T Function(AuthResponse response) data,
  }) async {
    try {
      //?loggin :
      final response = await supabase.auth
          .signInWithPassword(password: password, email: email);

      //?get the data for user :
      final user = await SupabaseGetMethods<UserEntity>().getSingleItem(
          table: 'users_app',
          data: (json) => UserEntity.fromJson(json),
          id: response.user!.id);

      AppSharedPref.cacheId(user.id!);
      AppSharedPref.cacheUserImage(user.imageUrl ?? '');
      AppSharedPref.cacheUsername(user.name ?? '');
      Logger().log(Level.info, 'done');
      return data(response);

      //?supabase exceptions :
    } on PostgrestException catch (e) {
      Logger().e(e.details);

      throw ServerException(e.message);

      //?auth exceptions :
    } on AuthException catch (e) {
      Logger().e(e.message);

      throw ServerException(e.message);

      //?server exceptions :
    } on ServerException catch (e) {
      Logger().e(e.message);
      throw ServerException(e.message);

      //?another exceptions :
    } catch (e) {
      Logger().e(e.toString());

      throw ServerException(e.toString());
    }
  }

  //?Regiter :
  Future<T> signup({
    required String email,
    required String password,
    required String username,
    required T Function(AuthResponse response) data,
  }) async {
    try {
      //?loggin :
      final response =
          await supabase.auth.signUp(password: password, email: email);

      final user = UserEntity(
        id: response.user!.id,
        bio: '',
        displayName: username,
        email: email,
        password: password,
        imageUrl: '',
        name: username,
        followers: [],
        followings: [],
      );

      await SupabasePostMethods<Unit>().add(
        body: user.toJson(),
        table: 'users_app',
        data: (_) {
          return unit;
        },
      );
      return data(response);

      //?supabase exceptions :
    } on PostgrestException catch (e) {
      Logger().e(e.details);
      throw ServerException(e.message);

      //?auth exceptions :
    } on AuthException catch (e) {
      Logger().e(e.message);
      throw ServerException(e.message);

      //?server exception
    } on ServerException catch (e) {
      Logger().e(e.message);
      throw ServerException(e.message);

      //?another exceptions :
    } catch (e) {
      Logger().e(e.toString());

      throw ServerException(e.toString());
    }
  }
}
