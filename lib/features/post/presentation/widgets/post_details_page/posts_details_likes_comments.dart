import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../profile/presentation/widgets/profile_details_section.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/resources/svg_manger.dart';
import '../../../domain/entity/post_entity.dart';

class PostDetailsLikesComments extends StatelessWidget {
  final PostEntity post;
  const PostDetailsLikesComments({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: Row(
        children: [
          const Spacer(),
          //?  Comments count :
          Text(
            '${post.comments?.length ?? ''}',
            style: Styles.body4.copyWith(color: AppColorManger.textSecondry),
          ),
          SizedBox(width: 6.w),
          SvgPicture.asset(AppSvgManger.comment, width: 20.w),

          const Spacer(),

          //?  Likes count :
          MaterialButton(
            onPressed: () {
              bottomSheetForProfiles(context,
                  title: 'Likes',
                  ids: post.likes ?? [],
                  emptyMessage: 'There is no likes yet!');
            },
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Text(
                  '${post.likes?.length}',
                  style:
                      Styles.body4.copyWith(color: AppColorManger.textSecondry),
                ),
                SizedBox(width: 6.w),
                SvgPicture.asset(AppSvgManger.heartOutlineColored, width: 20.w),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
