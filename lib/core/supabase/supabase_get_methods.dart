import '../error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseGetMethods<T> {
  final supabase = Supabase.instance.client;
  final session = Supabase.instance.client.auth.currentSession;

  //?get single data :
  Future<T> getSingleItem({
    required String table,
    List<String>? columns,
    required T Function(Map<String, dynamic> json) data,
    required String id,
  }) async {
    try {
      final String column;

      //?trim the columns if != null:
      if (columns != null) {
        column = columns.join(',');
      }

      //?return * if columns = null :
      else {
        column = '*';
      }

      //?return the json data :
      //?if (session == null || session?.accessToken == null) {
      //?  await supabase.auth.refreshSession();
      //?}
      final json =
          await supabase.from(table).select(column).eq('id', id).single();
      return data(json);

      //?Exception from supabase :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //?Another exception :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //?get data :
  Future<T> getData({
    required String table,
    List<String>? columns,
    required String order,
    required T Function(List<Map<String, dynamic>> json) data,
  }) async {
    try {
      final String column;

      //?trim the columns if != null:
      if (columns != null) {
        column = columns.join(',');
      }

      //?return * if columns = null :
      else {
        column = '*';
      }

      //?return the json data :
      final json = await supabase
          .from(table)
          .select(column)
          .order(order, ascending: true);
      return data(json);

      //?Exception from supabase :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //?Another exception :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  //?get data with filter :
  Future<T> getDataFiltring({
    required String table,
    List<String>? columns,
    required T Function(List<Map<String, dynamic>> json) data,
    dynamic eqVal,
    required String eqCol,
    required String order,
  }) async {
    try {
      final String column;

      //?trim the columns if != null:
      if (columns != null) {
        column = columns.join(',');
      }

      //?return * if columns = null :
      else {
        column = '*';
      }

      //?fetch all data :
      final allData =
          await supabase.from(table).select(column).eq(eqCol, eqVal).order(order,ascending: true);

      //?return the data :
      return data(allData);

      //?Exception from supabase :
    } on PostgrestException catch (e) {
      throw ServerException(e.message);

      //?Another exception :
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
