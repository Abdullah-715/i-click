//?Enum For Cubits Or Blocs
enum DeafultBlocStatus {
  initial,
  done,
  error,
  loading,
}

//? Enum for profile cubit :
enum ProfileEvent {
  initial,
  getProfile,
  updateProfile,
  addImage,
  pickImage,
  follow,
  deleteImage,
  changeFollow,
}

//? Enum for chat cubit :
enum ChatEvent {
  initial,
  getLastMessages,
  getMessages,
  sendMessages,
  readMessages,
  sendImage,
  selectImage,
}

//? Enum for auth cubit :
enum AuthEvent {
  initial,
  login,
  signup,
  verifyEmail,
  forgetPassword,
  changePassword,
  changeEmail,
}

//? Enum for notifications cubit :
enum NotificationEvent {
  initial,
  addNotification,
  setNotificationsAsReaded,
  getAllNotifications,
}

//? Enum for story cubit :
enum StoryEvent {
  initial,
  getAllStories,
  addStory,
  selectStoryPicture,
  showStory,
}

//? Enum for post cubit
enum PostEvent {
  initial,
  addImage,
  addPost,
  deletePost,
  editPost,
  getAllPosts,
  getPost,
  likePost,
  picImage,
}
