import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../auth/domain/entities/user_entity.dart';
import 'story_circle_avatar.dart';
import '../../../../router/routes.dart';

class StoryWidget extends StatelessWidget {
  final UserEntity story;
  const StoryWidget({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: story.id!,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).push(AppRoutes.storyDetailsPage, extra: story);
        },
        child: SizedBox(
          width: 50.w,
          child: Column(
            children: [
              StoryCircleAvatar(story: story),
              Text(
                story.name ?? '',
                style: Styles.body5.copyWith(color: AppColorManger.black1),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
