import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../comments/presentation/widgets/add_comment_field.dart';
import '../../../../comments/presentation/widgets/comments_list.dart';
import '../../../domain/entity/post_entity.dart';
import 'post_details_page_app_bar.dart';
import 'post_for_details_page.dart';
import '../../../../profile/presentation/widgets/no_items_found.dart';

class PostDetailsPageBody extends StatelessWidget {
  final PostEntity post;
  final ScrollController controller;
  const PostDetailsPageBody({
    required this.controller,
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostDetailsPageAppBar(
          post: post,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                PostForDetailsPage(post: post),

                //?  Post desc :
                Container(
                  alignment: Alignment.topLeft,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(post.description ?? ''),
                ),

                //?  Comments for post :

                post.comments?.isNotEmpty ?? false
                    ? CommentsList(comments: post.comments!)
                    : const NoItemsFoundWidget()
                
              ],
            ),
          ),
        ),
        AddCommentField(post: post)
      ],
    );
  }
}
