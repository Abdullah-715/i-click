import '../shared/app_shared_prefrences.dart';
import '../../features/post/domain/entity/post_entity.dart';

class CheckFunctions {
  // Check the post auther :
  static bool checkPostUser({required PostEntity post}) {
    if (post.likes!.contains(AppSharedPref.getUserId())) {
      return true;
    } else {
      return false;
    }
  }
}
