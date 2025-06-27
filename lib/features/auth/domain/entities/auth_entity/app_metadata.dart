import 'package:equatable/equatable.dart';

class AppMetadata extends Equatable {
  final String? provider;
  final List<dynamic>? providers;

  const AppMetadata({this.provider, this.providers});

  factory AppMetadata.fromJson(Map<String, dynamic> json) => AppMetadata(
        provider: json['provider'] as String?,
        providers: json['providers'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'provider': provider,
        'providers': providers,
      };

  @override
  List<Object?> get props => [provider, providers];
}
