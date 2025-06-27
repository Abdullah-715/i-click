import '../error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDeleteMethods<T> {
  final supabase = Supabase.instance.client;

  Future<T> delete({
    required String table,
    required T Function(Map<String, dynamic> json) data,
    required String id,
  }) async {
    try {
      //? delete the data :
      final json = await supabase.from(table).delete().eq('id', id);
      return data(json);

      //? supabase exceptions :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //? another exceptions :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
