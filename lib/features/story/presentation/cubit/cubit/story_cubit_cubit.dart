import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/image_picker.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../../auth/domain/entities/user_entity.dart';
import '../../../domain/entity/story_entity.dart';
import '../../../domain/usecases/story_base_use_case.dart';

part 'story_cubit_state.dart';

List<UserEntity> storiesFromCubit = [];

class StoryCubit extends Cubit<StoryState> {
  StoryCubit(this.usecase) : super(StoryState.init());

  final StoryBaseUsecase usecase;

  //* Get all stories :

  Future<void> getAllStories() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: StoryEvent.getAllStories,
    ));
    final data = await usecase.getAllStories();
    data.fold(
        (failure) => emit(
              state.copyWith(
                status: DeafultBlocStatus.error,
                message: mapFailure(failure),
              ),
            ), (list) {
      if (storiesFromCubit != list) {
        storiesFromCubit.clear();
        storiesFromCubit.addAll(list);
      }

      emit(state.copyWith(status: DeafultBlocStatus.done, stories: list));
    });
  }
  //*

  //* Add story :
  Future<void> addStory({
    required StoryEntity story,
  }) async {
    emit(state.copyWith(
        status: DeafultBlocStatus.loading, event: StoryEvent.addStory));
    if (state.file != null) {
      final data = await usecase.addStory(story: story, file: state.file!);
      data.fold(
          (failure) => emit(state.copyWith(
              status: DeafultBlocStatus.error, message: mapFailure(failure))),
          (stories) => emit(state.copyWith(status: DeafultBlocStatus.done)));
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done));
    }
  }
  //*

  //* Select picture :
  Future<void> selectStoryPicture() async {
    emit(state.copyWith(
      status: DeafultBlocStatus.loading,
      event: StoryEvent.selectStoryPicture,
    ));
    final file = await pickImage();
    if (file != null) {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: file));
    } else {
      emit(state.copyWith(status: DeafultBlocStatus.done, file: null));
    }
  }
  //*

  //* Show story :
  Future<void> showStory({required String storyId}) async {
    emit(state.copyWith(
        status: DeafultBlocStatus.loading, event: StoryEvent.showStory));
    final data = await usecase.showStory(storyId: storyId);
    data.fold(
        (failure) => emit(state.copyWith(
            status: DeafultBlocStatus.error, message: mapFailure(failure))),
        (_) => emit(state.copyWith(status: DeafultBlocStatus.done)));
  }
}
