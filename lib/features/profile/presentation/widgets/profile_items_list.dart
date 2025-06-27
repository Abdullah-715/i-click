import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../post/domain/entity/post_entity.dart';
import 'no_items_found.dart';
import '../../../../router/routes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProfileItemsList extends StatelessWidget {
  final List<PostEntity>? posts;
  const ProfileItemsList({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return posts != null && (posts?.isNotEmpty ?? false)
        ? MasonryGridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 90.h),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: posts?.length ?? 0,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRoutes.postDetailsPageAnimation,
                    extra: {'post_id': posts![index].postId});
              },
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppColorManger.greyFive,
                  borderRadius: BorderRadius.circular(10.r),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: posts![index].postImageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        : const NoItemsFoundWidget();
  }
}
