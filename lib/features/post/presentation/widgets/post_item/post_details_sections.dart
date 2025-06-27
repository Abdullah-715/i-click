import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/widgets/alert/app_alert.dart';
import '../../../../../core/functions/date_time_function.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/resources/svg_manger.dart';
import '../../../../../core/shared/app_shared_prefrences.dart';
import '../../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../domain/entity/post_entity.dart';
import '../../cubit/post_cubit/post_cubit.dart';
import '../../../../../router/routes.dart';

class PostDetailsSection extends StatelessWidget {
  final PostEntity post;
  const PostDetailsSection({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColorManger.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10))),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      height: 50.h,
      child: InkWell(
        onTap: () {
          if (post.postCreatorId != AppSharedPref.getUserId()) {
            GoRouter.of(context)
                .push(AppRoutes.profilePage, extra: post.postCreatorId);
          }
        },
        child: Row(
          children: [
            UserImageOrLetterWidget(
                id: post.postCreatorId ?? '',
                image: post.postCreatorImageUrl ?? '',
                name: post.postCreatorName ?? ''),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Text(
                post.postCreatorName ?? '',
                overflow: TextOverflow.ellipsis,
                style: Styles.body3.copyWith(color: AppColorManger.textPrimary),
              ),
            ),
            const Spacer(),
            Text(
              getDateForApp(post.createTime!),
              style:
                  Styles.body4.copyWith(color: AppColorManger.textPlaceholder),
            ),

            //?  Delete icon :
            Visibility(
              visible: post.postCreatorId == AppSharedPref.getUserId(),
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () {
                      AppAlert.mainDialog(
                        context,
                        title: 'Delete Post',
                        body: 'Are You sure you want to delete this post?',
                        button: 'Delete',
                        onPress: () {
                          GoRouter.of(context).pop();
                          context.read<PostCubit>().deletePost(
                              postId: post.postId ?? '',
                              url: post.postImageUrl ?? '');
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      AppSvgManger.delete,
                      width: 24.w,
                      colorFilter: ColorFilter.mode(
                          AppColorManger.error, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
