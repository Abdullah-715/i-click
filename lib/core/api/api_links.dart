//! all api links

//? Api GET
class ApiGet {
  //? Core :

  static const getUsersByIds = 'rest/v1/rpc/get_users_by_ids';
  static const getUserToken = 'rest/v1/rpc/get_user_fcm';

  //? Auth :
  static const verifyEmail = 'auth/v1/verify';
  //? Profile :
  static const getProfileData = 'rest/v1/rpc/get_user_details';

  //? Posts :
  static const getAllPosts = 'rest/v1/rpc/get_all_posts';
  static const getSinglePost = 'rest/v1/rpc/get_post_with_comments';

  //? Comments :
  static const getComments = 'rest/v1/rpc/rest/v1/rpc/add_post_from_json';
  //? Story :
  static const getStories = 'rest/v1/rpc/get_user_and_followees_stories';

  //? Notifications :
  static const getNotifications = 'rest/v1/rpc/get_notifications';

  //? Chat :
  static const getLastMessages = 'rest/v1/rpc/get_last_messages';
  static const getAllMessages = 'rest/v1/rpc/get_messages_by_chat_id';

  //? Search : 
  static const getSearch = 'rest/v1/rpc/search_posts_and_users';

}
//?

//? Api POST
class ApiPost {
  //? Auth :
  static const login = 'auth/v1/token?grant_type=password';
  static const signup = 'auth/v1/signup';
  static const createUser = 'rest/v1/rpc/add_user';
  static const logout = 'rest/v1/rpc/logout';

  //? Post :
  static const addPost = 'rest/v1/rpc/add_post_from_json';

  //? Comments :
  static const addComment = 'rest/v1/rpc/add_comment_from_json';

  //? Story :
  static const addStory = 'rest/v1/rpc/add_story_from_json';
  static const showStory = 'rest/v1/rpc/update_story_view';

  //? Notifications :
  static const addNotification = 'rest/v1/rpc/add_notification';

  //? Chat :
  static const sendMessage = 'rest/v1/rpc/insert_message';
  static const readMessage = 'rest/v1/rpc/mark_messages_as_read';
}
//?

//? Api PUT
class ApiPut {
  //? Auth :
  static const changeEmail = 'auth/v1/user';

  //? Post :
  static const updatePost = 'rest/v1/rpc/update_post_from_json';
  static const likePost = 'rest/v1/rpc/toggle_post_like';

  //? Profile :
  static const updateProfile = 'rest/v1/rpc/update_user';
  static const followProfile = 'rest/v1/rpc/follow_unfollow';

  //? Notifications :
  static const setNotificationsAsReaded =
      'rest/v1/rpc/set_notifications_as_read';

  static const updateFcm = 'rest/v1/rpc/add_user_fcm_token';
}
//?

//? Api DELETE
class ApiDelete {
  //? Post :
  static const deletePost = 'rest/v1/rpc/delete_post_with_image';
}

//?
