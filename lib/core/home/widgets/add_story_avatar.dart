import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../resources/color_manger.dart';
import '../../resources/enum_manger.dart';
import '../../resources/styles.dart';
import '../../resources/svg_manger.dart';
import '../../shared/app_shared_prefrences.dart';
import '../../widgets/alert/app_alert.dart';
import '../../widgets/app_toast.dart';
import '../../../features/story/domain/entity/story_entity.dart';
import '../../../features/story/presentation/cubit/cubit/story_cubit_cubit.dart';
import 'package:uuid/uuid.dart';

class AddStoryAvatar extends StatelessWidget {
  const AddStoryAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryCubit, StoryState>(
      listener: (context, state) {
        if (state.event == StoryEvent.addStory) {
          if (state.status == DeafultBlocStatus.loading) {
            AppAlert.lodingAlert(context);
          } else if (state.status == DeafultBlocStatus.done) {
            GoRouter.of(context).pop();
            if (state.file != null) {
              AppToast.doneToast('your story added succesfullly');
              context.read<StoryCubit>().getAllStories();
            }
          } else {
            GoRouter.of(context).pop();
            AppToast.errorToast(state.message);
          }
        }

        if (state.event == StoryEvent.selectStoryPicture) {
          if (state.status == DeafultBlocStatus.done) {
            final id = const Uuid().v4();
            final story = StoryEntity(
                storyId: id,
                createTime: DateTime.now().toString(),
                userId: AppSharedPref.getUserId()!,
                imageUrl: '',
                shows: [],
                userImage: AppSharedPref.getUserImage()!,
                userName: AppSharedPref.getUserName()!);

            context.read<StoryCubit>().addStory(story: story);
          }
        }
      },
      child: InkWell(
        onTap: () {
          context.read<StoryCubit>().selectStoryPicture();
        },
        child: AppSharedPref.getUserId() != AppSharedPref.getUserImage()
            ? const ImageAvatar()
            : const NameAvatar(),
      ),
    );
  }
}

class NameAvatar extends StatelessWidget {
  const NameAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          alignment: Alignment.center,
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
              color: AppColorManger.circleAvatarBackground,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColorManger.primaryColor, width: 2)),
          child: Text(AppSharedPref.getUserName()?[0].toUpperCase() ?? '',
              style: Styles.body1.copyWith(color: AppColorManger.primaryColor)),
        ),
        SvgPicture.asset(
          AppSvgManger.add,
          width: 14.w,
        ),
      ],
    );
  }
}

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image:
                CachedNetworkImageProvider(AppSharedPref.getUserImage() ?? '')),
        color: AppColorManger.circleAvatarBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SvgPicture.asset(
        AppSvgManger.add,
        width: 14.w,
      ),
    );
  }
}
