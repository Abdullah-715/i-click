import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/resources/svg_manger.dart';
import '../../../domain/entity/post_entity.dart';

class PostLikesCommentSection extends StatelessWidget {
  final PostEntity post;
  const PostLikesCommentSection({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColorManger.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${post.comments!.length}',
            style: Styles.body4.copyWith(color: AppColorManger.textSecondry),
          ),
          SizedBox(width: 8.w),
          SvgPicture.asset(
            AppSvgManger.comment,
            width: 17.w,
          ),
          SizedBox(
            width: 16.w,
          ),
          Text(
            '${post.likes?.length ?? 0}',
            style: Styles.body4.copyWith(color: AppColorManger.textSecondry),
          ),
          SizedBox(width: 8.w),
          SvgPicture.asset(
            AppSvgManger.heartOutlineColored,
            width: 17.w,
          ),
          SizedBox(
            width: 16.w,
          ),
        ],
      ),
    );
  }
}
