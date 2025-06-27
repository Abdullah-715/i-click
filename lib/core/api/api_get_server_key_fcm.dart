import 'package:googleapis_auth/auth_io.dart';
import '../error/exception.dart';
import 'package:logger/web.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiGetServerKey {
  Map<String, dynamic> getCredentials() {
    String jsonString = dotenv.env['GOOGLE_CLOUD_CREDENTIALS'] ?? '{}';
    return jsonDecode(jsonString);
  }

  Future<String> getServerKey() async {
    try {
      final scopes = [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/firebase.database',
        'https://www.googleapis.com/auth/firebase.messaging',
      ];

      final client = await clientViaServiceAccount(
          ServiceAccountCredentials.fromJson(getCredentials()), scopes);

      final accesServerKey = client.credentials.accessToken.data;

      return accesServerKey;
    } catch (e) {
      Logger().e(e);
      throw ServerException(e.toString());
    }
  }
}
