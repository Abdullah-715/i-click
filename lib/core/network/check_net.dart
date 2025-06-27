import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../error/exception.dart';
import '../error/failure.dart';
import 'network_info.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckNet<T> {
  NetworkInfo networkInformation =
      NetworkInfoImplemntes(InternetConnectionChecker());

  Either<Failure, T> checkRes({
    required Right<Failure, T> Function() tryRight,
  }) {
    try {
      return tryRight();
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<Failure, T>> checkNetResponse({
    required Future<Right<Failure, T>> Function() tryRight,
    Future<Right<Failure, T>> Function()? tryRightCach,
  }) async {
    if (await networkInformation.isConnected) {
      try {
        return await tryRight();
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on PostgrestException catch (e) {
        return Left(ServerFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      if (tryRightCach == null) {
        print('---------------------------------------------ofline!');
        return Left(OfflineFailure());
      } else {
        try {
          return await tryRightCach();
        } on EmptyCacheException {
          return Left(OfflineFailure());
        }
      }
    }
  }
}
