import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entity/comment_entity.dart';
import 'comment_item.dart';

class CommentsList extends StatelessWidget {
  final List<CommentEntity> comments;
  const CommentsList({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10.h),
        shrinkWrap: true,
        reverse: true,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index) => CommentItem(
              comment: comments[index],
            ));
  }
}
