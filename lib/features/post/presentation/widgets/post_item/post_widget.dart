import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../domain/entity/post_entity.dart';
import '../../cubit/post_cubit/post_cubit.dart';
import 'post_details_sections.dart';
import 'post_likes_comments_section.dart';
import '../../../../../router/routes.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;
  const PostWidget({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final data = await GoRouter.of(context)
            .push(AppRoutes.postDetailsPage, extra: {'post': post});

        if (data == null) {
          context.read<PostCubit>().getAllPosts(isFirst: false);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.h),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColorManger.black1, width: 0.5)),
        child: Column(
          children: [
            PostDetailsSection(post: post),

            Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: post.postId!,
                  child: Container(
                    color: AppColorManger.greyFive,
                    child: post.postImageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: post.postImageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                        : null,
                  ),
                ),
              ],
            ),
            PostLikesCommentSection(post: post)
          ],
        ),
      ),
    );
  }
}
