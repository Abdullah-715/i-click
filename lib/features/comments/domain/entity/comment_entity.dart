class CommentEntity {
  final String? commentId;
  final String? userName;
  final String? postId;
  final String? userImage;
  final String? createTime;
  final String? title;
  final String? userId;

  CommentEntity({
    this.commentId,
    this.postId,
    this.userName,
    this.userImage,
    this.createTime,
    this.title,
    this.userId,
  });

  factory CommentEntity.fromJson(Map<String, dynamic> data) {
    return CommentEntity(
      createTime: data['create_time'],
      userImage: data['user_image'],
      title: data['title'],
      userName: data['user_name'],
      commentId: data['id'],
      postId: data['post_id'],
      userId: data['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'create_time': createTime,
        'id': commentId,
        'user_image': userImage,
        'title': title,
        'post_id': postId,
        'user_name': userName,
        'user_id': userId,
      };
}
