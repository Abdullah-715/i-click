import 'pagenation_model.dart';
import 'package:http/http.dart' as http;

class ResponseModel {
  final String? message;
  final bool? succes;
  final dynamic data;
  final dynamic code;
  final String? details;
  final String? hint;
  final PagenationModel? pagenation;
  final http.Response? response;

  ResponseModel(
      {this.message,
      this.succes,
      this.data,
      this.code,
      this.details,
      this.hint,
      this.response,
      this.pagenation});

  factory ResponseModel.fromJson(Map<String, dynamic> map,
      {http.Response? response}) {
    return ResponseModel(
        message: map['message'] != null ? map['message'] as String : null,
        succes: map['succes'] != null ? map['succes'] as bool : null,
        data: map['data'] as dynamic,
        code: map['code'] as dynamic,
        details: map['details'] != null ? map['details'] as String : null,
        hint: map['hint'] != null ? map['hint'] as String : null,
        response: response,
        pagenation: map['pagination'] != null
            ? PagenationModel.fromJson(map['pagination'])
            : null);
  }
}
