import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/functions/date_time_function.dart';
import '../../../../../core/widgets/user_image_or_letter_widget.dart';
import '../../../../../core/cubit/short_users_cubit/short_users_cubit.dart';
import '../../../../../core/packages/story_package.dart';
import '../../../../../core/resources/color_manger.dart';
import '../../../../../core/resources/styles.dart';
import '../../../../../core/shared/app_shared_prefrences.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/entity/story_entity.dart';
import '../../cubit/cubit/story_cubit_cubit.dart';
import '../../../../../injection/injection_container.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';

class StoryDetailsWidget extends StatefulWidget {
  const StoryDetailsWidget(
      {super.key, required this.user, required this.pageController});

  final UserEntity user;
  final PageController pageController;

  @override
  State<StoryDetailsWidget> createState() => _StoryDetailsWidgetState();
}

class _StoryDetailsWidgetState extends State<StoryDetailsWidget> {
  List<StoryItem> storyItems = [];
  late StoryController storyController;

  @override
  void initState() {
    storyController = StoryController();
    addStoryItems();
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  void addStoryItems() {
    for (var story in widget.user.stories ?? <StoryEntity?>[]) {
      final ids = story?.shows.map((e) => e.toString()).toList();
      final storyItem = StoryItem.pageImage(
        ids: ids!,
        url: story?.imageUrl ?? '',
        controller: storyController,
        bottom: AppSharedPref.getUserId() == story!.userId
            ? Text(
                '${story.shows.length} views',
                style: Styles.body3
                    .copyWith(color: AppColorManger.textPlaceholder),
              )
            : null,
        duration: const Duration(seconds: 10),
      );
      storyItems.add(storyItem);
    }
  }

  void onComplete() {
    widget.pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    final currentIndex = storiesFromCubit.indexOf(widget.user);

    final isLastPage = storiesFromCubit.length - 1 == currentIndex;

    if (isLastPage) {
      GoRouter.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    StoryEntity? model = widget.user.stories?[0];
    return BlocProvider(
      create: (context) => sl<ShortUsersCubit>(),
      child: Stack(children: [

        StoryView(
          storyItems: storyItems,
          controller: storyController,
          onComplete: onComplete,
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              GoRouter.of(context).pop();
            }
          },
          onStoryShow: (storyItem, index) {
            //? ? Get story id :
            final story = widget.user.stories?[index];

            model = widget.user.stories?[index];
            print('****************************${model?.storyId}');

            if (!story!.shows.contains(AppSharedPref.getUserId()) &&
                story.userId != AppSharedPref.getUserId()) {
              context.read<StoryCubit>().showStory(storyId: story.storyId);
            }
          },
        ),
        Positioned(
            top: 50.h,
            left: 20.w,
            child: Row(
              children: [
                //?  User image :
                //? TODO

                UserImageOrLetterWidget(
                    width: 30.h,
                    height: 30.h,
                    id: widget.user.id ?? '',
                    image: widget.user.imageUrl ?? '',
                    name: widget.user.name ?? ''),
                SizedBox(width: 10.w),
               
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //?  User name :
                    Text(
                      model?.userName.toString() ?? '',
                      style: Styles.body3.copyWith(
                        color: AppColorManger.textPlaceholder,
                      ),
                    ),

                    //?  Date time :
                    Text(
                      getDateForApp(model?.createTime ?? ''),
                      style: Styles.body4
                          .copyWith(color: AppColorManger.greyEight),
                    )
                  ],
                )
              ],
            ))
      ]),
    );
  }
}

