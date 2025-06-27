import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../model/auth_request_model.dart';
import '../model/response_model.dart';

import '../error/exception.dart';
import 'package:http/http.dart' as http;

import 'api_methods.dart';
import 'api_url.dart';

class ApiPostMethods<T> {
  final String contentType;
  late Map<String, String> headers;
  final Map<String, String>? addHeader;
  ApiPostMethods({this.contentType = "application/json", this.addHeader}) {
    headers = ApiMethods().headersConst(contentType: contentType);
    if (addHeader != null && (addHeader?.isNotEmpty ?? false)) {
      headers.addAll(addHeader ?? {});
    }
  }

  /// using this function for all post requests
  /// when the parameter does not needed set as empty value
  Future<T> post({
    required String url,
    required T Function(Response response) data,
    body,
    encodeFormbody,
    Map<String, dynamic>? query,
    Map<String, String>? headeradd,
    bool isAuth = false,
  }) async {
    //? encode for data body
    //? this is content % this is fun use
    String encodeFormData(Map<String, String> data) {
      return data.keys.map((key) {
        final encodedKey = Uri.encodeComponent(key);
        final encodedValue = Uri.encodeComponent(data[key] ?? "");
        return '$encodedKey=$encodedValue';
      }).join('&');
    }

    body ??= {};
    //?

    query?.removeWhere((key, value) => value == null);

    ApiMethods().logRequest(
        url: url, query: query, body: body ?? encodeFormData(encodeFormbody));

    if (headeradd?.isNotEmpty ?? false) {
      headers.addAll(headeradd ?? {});
    }

    //? detetcted 1:
    try {
      http.Response response;
      if ((body != null || encodeFormbody != null) &&
          (query?.isNotEmpty ?? false)) {
        response = await http
            .post(
              ApiUrl(url).getQuery(query ?? {}).getLink(),
              body: encodeFormbody != null
                  ? encodeFormData(encodeFormbody)
                  : jsonEncode(body),
              headers: headers,
            )
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () => http.Response("Time Out", -1),
            );
      } else if (query?.isNotEmpty ?? false) {
        response = await http
            .post(ApiUrl(url).getQuery(query ?? {}).getLink(), headers: headers)
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () => http.Response("Time Out", -1),
            );
      } else {
        response = await http.post(ApiUrl(url).getLink(),
            body: jsonEncode(body), headers: headers);
      }

      ApiMethods().logResponse(response, url);

      //? Check if its for auth :
      if (!isAuth) {
        //? if request succes :
        if (response.statusCode == 200) {
          final dataDecoded = jsonDecode(response.body) as Map<String, dynamic>;
          final responseModel = ResponseModel.fromJson(dataDecoded);

          //? if response succes :
          if (responseModel.succes ?? false) {
            return data(response);

            //? the message from response :
          } else {
            throw ServerException(
                responseModel.message ?? responseModel.details ?? 'error');
          }
        } else {
          final dataDecoded = jsonDecode(response.body) as Map<String, dynamic>;
          final responseModel = ResponseModel.fromJson(dataDecoded);
          throw ServerException(
              responseModel.message ?? responseModel.details ?? 'error');
        }
      } else {
        if (response.statusCode == 200) {
          return data(response);
        } else {
          final dataDecoded = jsonDecode(response.body) as Map<String, dynamic>;
          final responseModel = AuthRequestModel.fromJson(dataDecoded);
          throw ServerException(
              responseModel.msg ?? responseModel.message ?? 'Auth Exception');
        }
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
      throw ServerException(e.toString());
    }
  }
}
