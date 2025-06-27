import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/functions/date_time_function.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../domain/entity/comment_entity.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  const CommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      constraints: BoxConstraints(minHeight: 104.h),
      decoration: BoxDecoration(
          color: AppColorManger.greyBackground,
          borderRadius: BorderRadius.circular(8.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? Comment user image :
          Container(
            width: 30.w,
            height: 30.w,
            alignment:
                comment.userImage != comment.userId ? null : Alignment.center,
            margin: EdgeInsets.only(right: 14.w),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColorManger.greyFive),
            child: comment.userImage != comment.userId
                ? ClipOval(
                    child: CachedNetworkImage(
                    imageUrl: comment.userImage!,
                    fit: BoxFit.cover,
                  ))
                : Text(
                    comment.userName![0].toUpperCase(),
                    style: Styles.body4
                        .copyWith(color: AppColorManger.primaryColor),
                  ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? Comment user name :
                Text(
                  comment.userName!,
                  style: Styles.title2.copyWith(color: AppColorManger.black2),
                ),
                SizedBox(height: 4.h),

                //? Comment title :
                Text(
                  comment.title!,
                  style: Styles.body4.copyWith(color: AppColorManger.black2),
                ),

                SizedBox(height: 10.h),

                //? Commnet create time :
                Text(
                  getDateForApp(comment.createTime!),
                  style: Styles.body5
                      .copyWith(color: AppColorManger.textPlaceholder),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
