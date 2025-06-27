import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../domain/entity/post_entity.dart';
import 'post_widget.dart';

class PostsList extends StatelessWidget {
  final List<PostEntity> posts;
  final bool hasReachedMax;
  final ScrollController controller;
  const PostsList({
    super.key,
    required this.posts,
    required this.controller,
    required this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 375.w,
        decoration: BoxDecoration(
          color: AppColorManger.greyBackground,
        ),
        child: ListView.builder(
          reverse: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 13.w, right: 13.w, bottom: 95.h),
          itemCount: posts.length,
          itemBuilder: (context, index) {
           
            return PostWidget(post: posts[index]);

          },
        ));
  }
}

