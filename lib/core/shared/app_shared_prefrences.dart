import '../resources/keys_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late SharedPreferences _sharedPref;

  static init(SharedPreferences sharedPreferences) {
    _sharedPref = sharedPreferences;
  }

  //? For clear cache :
  static void clear() async {
    await _sharedPref.clear();
  }

//? Caching :
  //? id :
  static void cacheId(String id) async {
    await _sharedPref.setString(AppKeysManger.id, id);
  }

  //? email :
  static void cacheEmail(String email) async {
    await _sharedPref.setString(AppKeysManger.email, email);
  }

  //? token :
  static void cacheToken(String token) async {
    await _sharedPref.setString(AppKeysManger.token, token);
  }

  //? fcm server token :
  static void cacheFcmServerToken(String token) async {
    await _sharedPref.setString(AppKeysManger.fcmServer, token);
  }

  //? user name :
  static void cacheUsername(String name) async {
    await _sharedPref.setString(AppKeysManger.name, name);
  }

  //? user name :
  static void cacheUserImage(String image) async {
    await _sharedPref.setString(AppKeysManger.imageUrl, image);
  }

//? Get :
  //? id :
  static String? getUserId() {
    return _sharedPref.getString(AppKeysManger.id);
  }

  //? id :
  static String? getUserEmail() {
    return _sharedPref.getString(AppKeysManger.email);
  }

  //? token :
  static String? getUserToken() {
    return _sharedPref.getString(AppKeysManger.token);
  }

  //? fcm srever token :
  //? static String? getFcmServerToken() {
  //?   return _sharedPref.getString(AppKeysManger.fcmServer);
  //? }

  //? user name :
  static String? getUserName() {
    return _sharedPref.getString(AppKeysManger.name);
  }

  //? user image :
  static String? getUserImage() {
    final image = _sharedPref.getString(AppKeysManger.imageUrl);
    if (image == null || image.isEmpty) return null;
    return image;
  }
}
