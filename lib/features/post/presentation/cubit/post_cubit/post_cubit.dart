import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/image_picker.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../domain/usecases/posts_base_use_case.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  //? This is the controller :
  final StreamController<List<PostEntity>> _controller =
      StreamController<List<PostEntity>>();

  PostCubit(this.usecase) : super(PostState.init());

  final PostsBaseUseCase usecase;

  
  //* For add post :
  Future<void> addPost({required PostEntity post, required File file}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: PostEvent.addPost,
    ));
    final data = await usecase.addPost(post: post, file: file);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }
  //*

  //* For delete post :
  Future<void> deletePost({required String postId, required String url}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: PostEvent.deletePost,
    ));
    final data = await usecase.deletePost(postId: postId, url: url);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }

  //*

  //* For edit post :
  Future<void> editPost({required PostEntity post}) async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: PostEvent.editPost,
    ));
    final data = await usecase.updatePost(post: post);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }

  //*
  //* Test :
  void like({required bool isLike}) {
    emit(state.copyWith(isLike: isLike));
  }
  //*

  //* for get all posts :
  int start = 0;
  Future<void> getAllPosts({bool isFirst = true}) async {
    emit(state.copyWith(event: PostEvent.getAllPosts));
    if (state.hasReachedMax) return;

    
    emit(state.copyWith(status: DeafultBlocStatus.loading));

    if (state.status == DeafultBlocStatus.loading) {
      final data = await usecase.getAllPosts(limit: 3, start: start);
      data.fold(
          (failure) => emit(state.copyWith(
                message: mapFailure(failure),
                status: DeafultBlocStatus.error,
              )), (data) {
        if (data.data.isEmpty) {
          emit(state.copyWith(
              hasReachedMax: true, status: DeafultBlocStatus.done));
        } else {
          emit(state.copyWith(
            status: DeafultBlocStatus.done,
            posts: data.data,
            hasReachedMax: false,
          ));
        }
      });
    } else {
      final data =
          await usecase.getAllPosts(limit: 3, start: state.posts.length);

      data.fold(
        (failure) => emit(state.copyWith(
          message: mapFailure( failure),
          status: DeafultBlocStatus.error,
        )),
        (data) {
          if (data.data.isEmpty) {
            emit(state.copyWith(hasReachedMax: true , status: DeafultBlocStatus.done));
          } else {
            emit(
              state.copyWith(
                  status: DeafultBlocStatus.done,
                  posts: List.of(state.posts)
                    ..addAll(data.data),
                  hasReachedMax: false),
            );
          }
        },
      );
    }

    final data = await usecase.getAllPosts(limit: 3, start: start);

  }
  //*

  //* for get single post :
  Future<void> getPost({required String postId, bool isFirst = true}) async {
    emit(state.copyWith(event: PostEvent.getPost));
    if (isFirst) {
      emit(state.copyWith(status: DeafultBlocStatus.loading));
    }
    final data = await usecase.getSinglePosts(postId: postId);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (post) => emit(state.copyWith(
        status: DeafultBlocStatus.done,
        post: post,
      )),
    );
  }
  //*

  //* For Like post :
  Future<void> likePost({required String postId, bool isLike = true}) async {
    emit(state.copyWith(
      event: PostEvent.likePost,
    ));
    final data = await usecase.likePost(postId: postId, isLike: isLike);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (post) =>
          emit(state.copyWith(status: DeafultBlocStatus.done, post: post)),
    );
  }
  //*

  //* For pick image :
  Future<void> picImage() async {
    emit(state.copyWith(
      event: PostEvent.picImage,
    ));
    final file = await pickImage();
    if (file != null) {
      emit(state.copyWith(
          status: DeafultBlocStatus.done,
          imageFile: file,
          event: PostEvent.picImage));
    } else {
    }
  }
  //*

  @override
  Future<void> close() {
    _controller.close();
    return super.close();
  }
}
