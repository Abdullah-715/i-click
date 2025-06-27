import '../error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePostMethods<T> {
  final supabase = Supabase.instance.client;

  //?Post data :
  Future<T> add({
    required Map<String, dynamic> body,
    required String table,
    required T Function(Map<String, dynamic>? json) data,
  }) async {
    try {
      //?add the data :
      final json = await supabase.from(table).insert(body);
      return data(json);

      //?supabase exceptions :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //?another exceptions :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
