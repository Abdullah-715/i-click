import 'package:equatable/equatable.dart';

class IdentityData extends Equatable {
  final String? email;
  final bool? emailVerified;
  final bool? phoneVerified;
  final String? sub;

  const IdentityData({
    this.email,
    this.emailVerified,
    this.phoneVerified,
    this.sub,
  });

  factory IdentityData.fromJson(Map<String, dynamic> json) => IdentityData(
        email: json['email'] as String?,
        emailVerified: json['email_verified'] as bool?,
        phoneVerified: json['phone_verified'] as bool?,
        sub: json['sub'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'email_verified': emailVerified,
        'phone_verified': phoneVerified,
        'sub': sub,
      };

  @override
  List<Object?> get props => [email, emailVerified, phoneVerified, sub];
}
