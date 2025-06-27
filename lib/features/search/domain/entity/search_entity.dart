import '../../../auth/domain/entities/user_entity.dart';
import '../../../post/domain/entity/post_entity.dart';

class SearchEntity {
  final List<UserEntity> users;
  final List<PostEntity> posts;
  SearchEntity({
    required this.users,
    required this.posts,
  });

  SearchEntity copyWith({
    List<UserEntity>? users,
    List<PostEntity>? posts,
  }) {
    return SearchEntity(
      users: users ?? this.users,
      posts: posts ?? this.posts,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'users': users,
      'posts': posts,
    };
  }

  factory SearchEntity.fromJson(Map<String, dynamic> json) {
    return SearchEntity(
      users: List<UserEntity>.from(
        (json['users'] as List).map<UserEntity>(
          (x) => UserEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
      posts: List<PostEntity>.from(
        (json['posts'] as List).map<PostEntity>(
          (x) => PostEntity.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
