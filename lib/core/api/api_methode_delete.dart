import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/response_model.dart';

import '../error/exception.dart';
import 'api_methods.dart';
import 'api_url.dart';

class ApiDeleteMethods<T> {
  final String contentType;
  late Map<String, String> headers;
  final Map<String, String>? addHeader;
  ApiDeleteMethods({this.contentType = "application/json", this.addHeader}) {
    headers = ApiMethods().headersConst(contentType: contentType);
    if (addHeader != null && (addHeader?.isNotEmpty ?? false)) {
      headers.addAll(addHeader ?? {});
    }
  }

  /// using this function for all delete requests
  /// when the parameter does not needed set as empty value
  Future<T> delete(
      {required String url,
      required T Function(Response response) data,
      path,
      Map<String, dynamic>? query}) async {
    ApiMethods().logRequest(url: url, query: query, path: {'': path});
    http.Response response;

    try {
      if (query?.isNotEmpty ?? false) {
        response = await http
            .delete(ApiUrl(url).getQuery(query ?? {}).getLink(),
                headers: headers)
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () => http.Response("Time Out", -1),
            );
      } else {
        response =
            await http.delete(ApiUrl(url).getLink(), headers: headers).timeout(
                  const Duration(seconds: 30),
                  onTimeout: () => http.Response("Time Out", -1),
                );
      }
      ApiMethods().logResponse(response, url);
      if (response.statusCode == 200) {
        final dataDecoded = jsonDecode(response.body) as Map<String, dynamic>;
        final responseModel = ResponseModel.fromJson(dataDecoded);
        if (responseModel.succes ?? true) {
          return data(response);
        } else {
          throw ServerException(responseModel.message ?? 'Auth error');
        }
      } else {
        final dataDecoded = jsonDecode(response.body) as Map<String, dynamic>;
        final responseModel = ResponseModel.fromJson(dataDecoded);
        throw ServerException(responseModel.message ?? 'Auth error');
      }
    } on TimeoutException catch (_) {
      // Handle timeout exception here
      if (kDebugMode) {
        print("Request timed out");
      }
      throw ServerException('Request timed out');
    } on ServerException catch (e) {
      // Handle other exceptions

      if (kDebugMode) {
        print("Error: ${e.message}");
      }
      rethrow;
    } catch (e) {
      // Handle other exceptions

      if (kDebugMode) {
        print("Error: $e");
      }
      throw ServerException('0');
    }
  }
}
