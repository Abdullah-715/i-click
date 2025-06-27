import '../../../comments/domain/entity/comment_entity.dart';

class PostEntity {
  //?  Details for post:
  final String? postId;
  final String? description;
  final String? postImageUrl;
  final List? likes;
  final String? createTime;
  final List<CommentEntity>? comments;

  //?  Details for post creator :
  final String? postCreatorName;
  final String? postCreatorId;
  final String? postCreatorImageUrl;

  PostEntity(
      {this.postId,
      this.postCreatorName,
      this.createTime,
      this.postCreatorId,
      this.description,
      this.postImageUrl,
      this.postCreatorImageUrl,
      this.likes,
      this.comments});

  factory PostEntity.fromJson(Map<String, dynamic> data) {
    return PostEntity(
        postId: data['id'],
        postCreatorId: data['post_creator_id'],
        description: data['description'],
        postImageUrl: data['post_image_url'],
        createTime: data['create_time'],
        postCreatorImageUrl: data['post_creator_image_url'],
        likes: data['likes'] ?? [],
        postCreatorName: data['post_creator_name'],
        comments: List.from(data['comments'] ?? [])
            .map((e) => CommentEntity.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {
      'id': postId,
      'post_creator_id': postCreatorId,
      'post_image_url': postImageUrl,
      'likes': likes,
      //?  'comments': comments,
      'create_time': createTime,
      'post_creator_image_url': postCreatorImageUrl,
      'description': description,
      'post_creator_name': postCreatorName,
    };
  }

  PostEntity copyWith({
    String? postId,
    String? description,
    String? postImageUrl,
    List? likes,
    String? createTime,
    List? comments,
    String? postCreatorName,
    String? postCreatorId,
    String? postCreatorImageUrl,
  }) {
    return PostEntity(
      postId: postId ?? this.postId,
      postCreatorId: postCreatorId ?? this.postCreatorId,
      description: description ?? this.description,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      createTime: createTime ?? this.createTime,
      postCreatorImageUrl: postCreatorImageUrl ?? this.postCreatorImageUrl,
      likes: likes ?? this.likes,
      postCreatorName: postCreatorName ?? this.postCreatorName,
      //?  comments: comments ?? this.comments,
    );
  }
}
