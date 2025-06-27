import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../../domain/usecases/comment_base_use_case.dart';

part 'get_all_comments_state.dart';

class GetAllCommentsCubit extends Cubit<GetAllCommentsState> {
  GetAllCommentsCubit(this.usecase) : super(GetAllCommentsState.init());

  final CommentBaseUsecase usecase;

  Future<void> getComments({required String postId}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));
    final data = await usecase.getComments(postId: postId);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (comments) => emit(
          state.copyWith(status: DeafultBlocStatus.done, comments: comments)),
    );
  }
}
