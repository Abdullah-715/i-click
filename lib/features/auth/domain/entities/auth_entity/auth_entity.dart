import 'package:equatable/equatable.dart';

import 'user.dart';

class AuthEntity extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final int? expiresAt;
  final String? refreshToken;
  final User? user;

  const AuthEntity({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.expiresAt,
    this.refreshToken,
    this.user,
  });

  factory AuthEntity.fromJson(Map<String, dynamic> json) => AuthEntity(
        accessToken: json['access_token'] as String?,
        tokenType: json['token_type'] as String?,
        expiresIn: json['expires_in'] as int?,
        expiresAt: json['expires_at'] as int?,
        refreshToken: json['refresh_token'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'expires_at': expiresAt,
        'refresh_token': refreshToken,
        'user': user?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      accessToken,
      tokenType,
      expiresIn,
      expiresAt,
      refreshToken,
      user,
    ];
  }
}
