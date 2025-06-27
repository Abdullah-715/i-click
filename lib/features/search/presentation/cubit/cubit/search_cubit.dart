import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/functions/map_failure.dart';
import '../../../../../core/resources/enum_manger.dart';
import '../../../domain/entity/search_entity.dart';
import '../../../domain/usecases/search_base_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.useCase) : super(SearchState.init());

  final SearchBaseUseCase useCase;

  //* for get search :
  Future<void> getSearch({required String search}) async {
    emit(state.copyWith(status: DeafultBlocStatus.loading));
    final data = await useCase.getSearch(search: search);
    data.fold(
        (failure) => emit(state.copyWith(
            status: DeafultBlocStatus.error, message: mapFailure(failure))),
        (search) => emit(state.copyWith(
            status: DeafultBlocStatus.done, searchEntity: search)));
  }
}
