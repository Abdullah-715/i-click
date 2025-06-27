import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/domain/entities/user_entity.dart';
import 'story_widget.dart';

class StoriesList extends StatelessWidget {
  final List<UserEntity?> list;
  const StoriesList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 375.w,
        height: 75.h,
        child: Row(
          children: [
            BaseList(list: list),
          ],
        ));
  }
}

class BaseList extends StatelessWidget {
  const BaseList({
    super.key,
    required this.list,
  });

  final List<UserEntity?> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          separatorBuilder: (context, _) => SizedBox(
                width: 24.w,
              ),
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return StoryWidget(
              story: list[index]!,
            );
          }),
    );
  }
}
