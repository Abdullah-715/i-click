import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manger.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/resources/styles.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/main_button.dart';
import '../../../../core/widgets/main_form_field.dart';
import '../../domain/entity/post_entity.dart';
import '../cubit/post_cubit/post_cubit.dart';
import '../logic/posts_logic.dart';
import '../widgets/add_post_page/add_post_page_app_bar.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    File? imageFile;
    String postId = const Uuid().v1();
    String desc = '';
    String url = '';
    return BlocConsumer<PostCubit, PostState>(
      listener: (context, state) =>
          PostLogic.addPostListener(state: state, context: context),
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddPostAppBar(onTap: () {
                  if (imageFile != null && desc.isNotEmpty) {
                    final post = PostEntity(
                      description: desc,
                      postId: postId,
                      postImageUrl: url,
                    );
                    context
                        .read<PostCubit>()
                        .addPost(post: post, file: imageFile!);
                    Logger().d(imageFile?.path);
                  } else {
                    AppToast.errorToast('image and description are required!');
                  }
                }),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: MainFormField(
                    onChanged: (val) => desc = val,
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
                BlocConsumer<PostCubit, PostState>(
                  listener: (context, state) => PostLogic.addImageListener(
                      state: state, context: context,imageFile: imageFile),
                  builder: (context, state) {
                    if (state.status == DeafultBlocStatus.done ||
                        state.imageFile != null) {
                      imageFile = state.imageFile;
                      url = state.url;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Image.file(state.imageFile!, fit: BoxFit.fill),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                
                   Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 16.h),
                    child: MainButton(
                      label: 'Add Image',
                      width: 128.w,
                      height: 36.h,
                      onPressed: () {
                        context.read<PostCubit>().picImage();
                       
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
