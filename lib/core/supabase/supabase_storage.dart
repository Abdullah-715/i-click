import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorage<T> {
  Future<T> uploadFile(
      {required File file,
      required T Function(String downloadUrl) data,
      required String bucket,
      required String name}) async {
    try {
      final storage = Supabase.instance.client.storage.from(bucket);
      //?get full name :
      final fileName = '$name.jpg';

      //?upload the image :
      await storage.upload(fileName, file);

      //?get the likn :
      final urlDownload = storage.getPublicUrl(fileName);

      Logger().i(urlDownload);
      return data(urlDownload);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<T> deleteImage({
    required String imageUrl,
    required String bucket,
    required T Function(Unit unit) data,
  }) async {
    try {
      //* Define the storage :

      final storage = Supabase.instance.client.storage.from(bucket);

      //* Get file name :
      final path = imageUrl.split('/').last;

      //* Delete :
      await storage.remove([path]);

      Logger().i(path);

      return data(unit);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
