import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/entity/comment_entity.dart';
import '../../../domain/usecases/comment_base_use_case.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.usecase) : super(AddCommentState.init());
  final CommentBaseUsecase usecase;

  Future<void> addComments(
      {required String postId, required CommentEntity comment}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));
    final data = await usecase.addComment(postId: postId, comment: comment);
    data.fold(
      (failure) => emit(state.copyWith(
          status: DeafultBlocStatus.error, message: mapFailure(failure))),
      (done) => emit(state.copyWith(status: DeafultBlocStatus.done)),
    );
  }
}
