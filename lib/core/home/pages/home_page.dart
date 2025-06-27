import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/alert/app_alert.dart';
import '../../widgets/app_toast.dart';
import '../widgets/home_page_app_bar.dart';
import '../../resources/enum_manger.dart';
import '../../widgets/shimmer_widget.dart';
import '../../../features/post/presentation/cubit/post_cubit/post_cubit.dart';
import '../../../features/post/presentation/widgets/post_item/post_shimmer_item.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/story/presentation/cubit/cubit/story_cubit_cubit.dart';
import '../../../features/story/presentation/widgets/stories_list.dart';
import '../../resources/color_manger.dart';
import '../../../features/post/presentation/widgets/post_item/posts_list.dart';
import '../../../features/story/presentation/widgets/stories_shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Container(
      color: AppColorManger.white,
      child: Column(
        children: [
          const HomePageAppBar(),
          Expanded(
            child: RefreshList(
              onRefresh: () async {
                context.read<PostCubit>().getAllPosts();
                context.read<StoryCubit>().getAllStories();
              },
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  BlocBuilder<StoryCubit, StoryState>(
                      builder: (context, state) {
                    if (state.status == DeafultBlocStatus.loading &&
                        state.event == StoryEvent.getAllStories) {
                      return const StoriesShimmer();
                    } else {
                      if (state.stories.isNotEmpty) {
                        return StoriesList(list: state.stories);
                      } else {
                        return const SizedBox();
                      }
                    }
                  }
                      ),
                  BlocConsumer<PostCubit, PostState>(
                    listener: (context, state) {
                      if (state.event == PostEvent.deletePost) {
                        if (state.status == DeafultBlocStatus.error) {
                          GoRouter.of(context).pop();
                          AppToast.errorToast(state.message);
                        } else if (state.status == DeafultBlocStatus.loading) {
                          AppAlert.lodingAlert(context);
                        } else {
                          GoRouter.of(context).pop();
                          AppToast.doneToast('You post deleted succesfully');
                          context.read<PostCubit>().getAllPosts();
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state.status == DeafultBlocStatus.done ||
                          state.posts.isNotEmpty) {
                        return PostsList(
                          posts: state.posts,
                          hasReachedMax: state.hasReachedMax,
                          controller: controller,
                        );
                      } else if (state.status == DeafultBlocStatus.loading &&
                          state.event == PostEvent.getAllPosts &&
                          state.posts.isEmpty) {
                        return const PostsShimmer();
                      }
                      if (state.status == DeafultBlocStatus.error &&
                          state.posts.isEmpty) {
                        return ErrorTextWidget(
                            isList: false,
                            message: state.message,
                            onRefresh: () async {
                              context.read<PostCubit>().getAllPosts();
                              context.read<StoryCubit>().getAllStories();
                            });
                      }
                      return ErrorTextWidget(
                          isList: false,
                          message: state.message,
                          onRefresh: () async {
                            context.read<PostCubit>().getAllPosts();
                            context.read<StoryCubit>().getAllStories();
                          });
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

//TODO : Cut it to other file
class PostsShimmer extends StatelessWidget {
  const PostsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShimmerWidget(
      child: Column(
        children: [PostShimmerItem(), PostShimmerItem()],
      ),
    );
  }
}
