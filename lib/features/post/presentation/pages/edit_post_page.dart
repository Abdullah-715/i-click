import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/main_form_field.dart';
import '../../domain/entity/post_entity.dart';
import '../cubit/post_cubit/post_cubit.dart';
import '../logic/posts_logic.dart';
import '../widgets/edit_post_page/edit_post_page_app_bar.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    String? value;
    return BlocListener<PostCubit, PostState>(
      listener: (context, state) => PostLogic.editPostListener(
          state: state, context: context, postId: post.postId!),
      child: Scaffold(
        body: Column(
          children: [
            EditPostAppBar(onTap: () {
              final postUpdated = post.copyWith(description: value);
              context.read<PostCubit>().editPost(
                    post: postUpdated,
                  );
            }),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: MainFormField(
                labelText: post.description,
                onChanged: (val) => value = val,
                minLines: 5,
                maxLines: 7,
                hint: 'description',
                horizontalPadding: 20.w,
                verticalPadding: 13.h,
                hintStyle: Styles.body3.copyWith(
                  color: AppColorManger.textPlaceholder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
