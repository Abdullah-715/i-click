import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import 'no_items_found.dart';
import '../../../story/domain/entity/story_entity.dart';

class ProfileStoriesList extends StatelessWidget {
  final List<StoryEntity>? stories;
  const ProfileStoriesList({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    return stories != null && (stories?.isNotEmpty ?? false)
        ? GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 95.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15.w,
              crossAxisSpacing: 15.w,
            ),
            itemCount: stories?.length ?? 0,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
               
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColorManger.greyFive,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: CachedNetworkImage(
                    imageUrl: stories![index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        : const NoItemsFoundWidget();
  }
}
