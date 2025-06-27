import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/functions/date_time_function.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../domain/entity/post_entity.dart';

class PostDetailsHead extends StatelessWidget {
  final PostEntity post;
  const PostDetailsHead({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      child: Row(
        children: [
          //?  User image :
          UserImageOrLetterWidget(
              id: post.postCreatorId ?? '',
              image: post.postCreatorImageUrl ?? '',
              name: post.postCreatorName ?? ''),

          SizedBox(width: 10.w),

          //?  User name :
          Text(
            post.postCreatorName!,
            style: Styles.body3.copyWith(color: AppColorManger.textPrimary),
          ),
          const Spacer(),

          //?  Date time :
          Text(
            getDateForApp(post.createTime!),
            style: Styles.body4.copyWith(color: AppColorManger.textPlaceholder),
          )
        ],
      ),
    );
  }
}

