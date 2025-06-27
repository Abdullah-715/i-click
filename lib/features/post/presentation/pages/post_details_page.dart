import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../comments/presentation/cubit/add_comment/add_comment_cubit.dart';
import '../../domain/entity/post_entity.dart';
import '../cubit/post_cubit/post_cubit.dart';
import '../widgets/post_details_page/post_details_page_body.dart';
import '../widgets/post_details_page/post_details_shimmer.dart';

class PostDetailsPage extends StatefulWidget {
  final PostEntity? post;
  final String? postId;
  const PostDetailsPage({super.key, this.post, this.postId});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  void initState() {
    if (widget.post == null) {
      context.read<PostCubit>().getPost(postId: widget.postId!);
    }
    super.initState();
  }

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddCommentCubit, AddCommentState>(
            listener: (context, state) {
              if (state.status == DeafultBlocStatus.done) {
                AppToast.additinalToast('your comment added succesfully');
                // Future.delayed(const Duration(milliseconds: 300), () {
                //   controller.animateTo(
                //     controller.position.maxScrollExtent,
                //     duration: const Duration(milliseconds: 300),
                //     curve: Curves.easeIn,
                //   );
                // });
                context.read<PostCubit>().getPost(
                    postId: widget.post?.postId! ?? widget.postId!,
                    isFirst: false);
              } else if (state.status == DeafultBlocStatus.error) {
                AppToast.errorToast(state.message);
                // isFromCubit = true;
              }
            },
          ),
          BlocListener<PostCubit, PostState>(
            listener: (context, state) {
              if (state.event == PostEvent.likePost) {
                if (state.status == DeafultBlocStatus.done) {
                  // AppToast.additinalToast('your like added succesfully');
                  context.read<PostCubit>().getPost(
                      postId: widget.post?.postId! ?? widget.postId!,
                      isFirst: false);
                }
              }
            },
          ),
        ],
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state.status == DeafultBlocStatus.loading) {
              return const PostDetailsPageShimmer();
            } else if (state.status == DeafultBlocStatus.error) {
              if (state.post.postId == null) {
                return ErrorTextWidget(
                    isList: state.post.postId != null,
                    message: state.message.contains("type 'Null'")
                        ? 'This post has deleted'
                        : state.message,
                    button: state.post.postId == null ? 'Back' : 'Try again...',
                    onRefresh: () async {
                      if (state.post.postId == null) {
                        GoRouter.of(context).pop();
                      } else {
                        context.read<PostCubit>().getPost(
                            postId: widget.postId ?? widget.post!.postId!);
                      }
                    });
              }
            }

            return PostDetailsPageBody(
              controller: controller,
              post: state.post.postId == null ? widget.post! : state.post,
            );
          },
        ),
      ),
    );
  }
}
