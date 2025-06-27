class StoryEntity {
  //? Data for story :
  final String storyId;
  final String createTime;
  final String userId;
  final String imageUrl;
  final List shows;

  //? Data for auther :
  final String userImage;
  final String userName;

  StoryEntity({
    required this.storyId,
    required this.createTime,
    required this.userId,
    required this.imageUrl,
    required this.shows,
    required this.userImage,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': storyId,
      'createTime': createTime,
      'userId': userId,
      'imageUrl': imageUrl,
      'shows': shows,
      'userImage': userImage,
      'userName': userName,
    };
  }

  factory StoryEntity.fromJson(Map<String, dynamic> json) {
    return StoryEntity(
      storyId: json['id'] as String,
      createTime: json['createTime'] as String,
      userId: json['userId'] as String,
      imageUrl: json['imageUrl'] as String,
      shows: List.from((json['shows'] as List)),
      userImage: json['userImage'] as String,
      userName: json['userName'] as String,
    );
  }

  StoryEntity copyWith({
    String? storyId,
    String? createTime,
    String? userId,
    String? imageUrl,
    List<String>? shows,
    String? userImage,
    String? userName,
  }) {
    return StoryEntity(
      storyId: storyId ?? this.storyId,
      createTime: createTime ?? this.createTime,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      shows: shows ?? this.shows,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
    );
  }
}
