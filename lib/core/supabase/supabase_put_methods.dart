import '../error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePutMethods<T> {
  final supabase = Supabase.instance.client;

  //?Post data :
  Future<T> update({
    required Map<String, dynamic> body,
    required String table,
    required T Function() data,
    required String id,
  }) async {
    try {
      //?update the data :
      await supabase.from(table).update(body).eq('id', id);
      return data();

      //?supabase exceptions :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //?another exceptions :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
