import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../domain/entity/post_entity.dart';
import 'post_details_head.dart';
import 'posts_details_likes_comments.dart';

class PostForDetailsPage extends StatelessWidget {
  final PostEntity post;
  const PostForDetailsPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          PostDetailsHead(post: post),

          //? Post image :
          Hero(
            tag: post.postId!,
            child: Container(
              color: AppColorManger.greyFive,
              child: post.postImageUrl?.isNotEmpty ?? false
                  ? CachedNetworkImage(
                      imageUrl: post.postImageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : null,
            ),
          ),

          PostDetailsLikesComments(post: post)
        ],
      ),
    );
  }
}
