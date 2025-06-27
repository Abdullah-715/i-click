import '../../../post/domain/entity/post_entity.dart';
import '../../../story/domain/entity/story_entity.dart';

class UserEntity {
  final String? name;
  final String? displayName;
  final String? id;
  final String? bio;
  final String? email;
  final String? password;
  final List<String>? fcmToken;
  final List? followers;
  final List? followings;
  final String? imageUrl;
  final List<PostEntity>? posts;
  final List<StoryEntity>? stories;

  UserEntity({
    this.fcmToken,
    this.stories,
    this.posts,
    this.imageUrl,
    this.name,
    this.displayName,
    this.id,
    this.bio,
    this.email,
    this.password,
    this.followers,
    this.followings,
  });

  factory UserEntity.fromJson(Map<String, dynamic> data) {
    return UserEntity(
      name: data['name'],
      displayName: data['display_name'],
      id: data['id'],
      bio: data['bio'],
      fcmToken: data['fcm_token'] != null ? List.from(data['fcm_token']) : [],
      email: data['email'],
      password: data['password'],
      followers: data['followers'],
      followings: data['following'],
      imageUrl: data['image_url'],
      posts: data['posts'] != null
          ? List.from(data['posts']).map((e) => PostEntity.fromJson(e)).toList()
          : [],
      stories: data['stories'] != null
          ? List.from(data['stories'])
              .map((e) => StoryEntity.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'display_name': displayName,
      'bio': bio,
      'fcm_token': fcmToken,
      'email': email,
      'password': password,
      'followers': followers,
      'following': followings,
      'image_url': imageUrl
    };
  }

  UserEntity copyWith({
    String? name,
    String? displayName,
    String? id,
    String? bio,
    String? email,
    String? password,
    List? followers,
    List? followings,
    String? imageUrl,
    List<PostEntity>? posts,
    List<StoryEntity>? stories,
  }) {
    return UserEntity(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      id: id ?? this.id,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      password: password ?? this.password,
      followings: followings ?? this.followings,
      followers: followers ?? this.followers,
      imageUrl: imageUrl ?? this.imageUrl,
      posts: posts ?? this.posts,
      stories: stories ?? this.stories,
    );
  }
}
