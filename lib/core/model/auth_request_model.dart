// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AuthRequestModel extends Equatable {
  final dynamic code;
  final String? errorCode;
  final String? msg;
  final String? details;
  final String? hint;
  final String? message;
  const AuthRequestModel({
    this.code,
    this.errorCode,
    this.msg,
    this.details,
    this.hint,
    this.message,
  });

  @override
  List<Object?> get props => [
        code,
        errorCode,
        msg,
        details,
        hashCode,
        message,
      ];

  factory AuthRequestModel.fromJson(Map<String, dynamic> map) {
    return AuthRequestModel(
      code: map['code'] as dynamic,
      errorCode: map['errorCode'] != null ? map['errorCode'] as String : null,
      msg: map['msg'] != null ? map['msg'] as String : null,
      details: map['details'] != null ? map['details'] as String : null,
      hint: map['hint'] != null ? map['hint'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }
}
