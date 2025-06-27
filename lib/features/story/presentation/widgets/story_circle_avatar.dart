import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../auth/domain/entities/user_entity.dart';

class StoryCircleAvatar extends StatelessWidget {
  final UserEntity story;
  const StoryCircleAvatar({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.h,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          colors: [
            AppColorManger.primaryLinearTow,
            AppColorManger.primaryLinearOne
          ],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(3.w),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColorManger.white,
          borderRadius: BorderRadius.circular(17.r),
        ),
        child: story.imageUrl != story.id
            ? Container(
                margin: EdgeInsets.all(1.w),
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17.r),
                  child: CachedNetworkImage(
                    imageUrl: story.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Text(
                story.name![0].toUpperCase(),
                style: Styles.body1.copyWith(
                    foreground: Paint()
                      ..shader = LinearGradient(colors: [
                        AppColorManger.primaryLinearTow,
                        AppColorManger.primaryLinearOne,
                      ]).createShader(Rect.fromLTWH(20, 0.0, 200.w, 70.h))),
              ),
      ),
    );
  }
}
