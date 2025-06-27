import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/resources/enum_manger.dart';
import '../../../../core/widgets/alert/app_alert.dart';
import '../../../../core/widgets/app_toast.dart';
import '../cubit/post_cubit/post_cubit.dart';
import '../../../../router/routes.dart';

class PostLogic {

  static Future<void> addImageListener({
    required PostState state,
    required BuildContext context,
        File? imageFile,

  }) async {
    if (state.event == PostEvent.picImage) {
      if (state.status == DeafultBlocStatus.done && state.imageFile != null) {
        imageFile = state.imageFile;
      }
    }
    if (state.event == PostEvent.addImage) {
      if (state.status == DeafultBlocStatus.loading) {
        AppAlert.lodingAlert(context);
      } else if (state.status == DeafultBlocStatus.error) {
        GoRouter.of(context).pop();
        AppToast.errorToast(state.message);
      } else {
        GoRouter.of(context).pop();
      }
    }
  }

  static void addPostListener({
    required PostState state,
    required BuildContext context,
  }) {
    if (state.event == PostEvent.addPost) {
      if (state.status == DeafultBlocStatus.loading) {
        AppAlert.lodingAlert(context);
      } else if (state.status == DeafultBlocStatus.error) {
        GoRouter.of(context).pop();
        AppToast.errorToast(state.message);
      } else {
        GoRouter.of(context).pop();
        AppToast.doneToast('Your post added succesfully!');
        GoRouter.of(context).pushReplacement(AppRoutes.homePage);
      }
    }
  }

  static void deletePostListener({
    required PostState state,
    required BuildContext context,
  }) {
    if (state.event == PostEvent.deletePost) {
      if (state.status == DeafultBlocStatus.loading) {
        AppAlert.lodingAlert(context);
      }
      if (state.status == DeafultBlocStatus.error) {
        AppToast.errorToast(state.message);
        GoRouter.of(context).pop();
      } else {
        AppToast.doneToast('Your post deleted succesfully!');
        GoRouter.of(context).pop();
      }
    }
  }

  static void editPostListener({
    required PostState state,
    required BuildContext context,
    required String postId,
  }) {
    if (state.event == PostEvent.editPost) {
      if (state.status == DeafultBlocStatus.loading) {
        AppAlert.lodingAlert(context);
      } else if (state.status == DeafultBlocStatus.error) {
        AppToast.errorToast(state.message);
        GoRouter.of(context).pop();
      } else if (state.status == DeafultBlocStatus.done) {
        GoRouter.of(context).pop();
        AppToast.doneToast('Your post updated succesfully!');
        GoRouter.of(context).pop();
      }
    }
  }

  static void picImageListener({
    required PostState state,
    required BuildContext context,
    File? imageFile,
  }) {
    if (state.event == PostEvent.picImage) {
      if (state.status == DeafultBlocStatus.done && state.imageFile != null) {
        imageFile = state.imageFile;
      }
    }
  }

  static void likePostListener({
    required PostState state,
    required BuildContext context,
  }) {
    if (state.event == PostEvent.likePost) {
      if (state.status == DeafultBlocStatus.done) {
        context.read<PostCubit>().getAllPosts(isFirst: false);
      }
    }
  }
}
