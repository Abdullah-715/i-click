part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.status,
    required this.searchEntity,
    required this.message,
  });
  final DeafultBlocStatus status;
  final SearchEntity searchEntity;
  final String message;

  @override
  List<Object> get props => [status, searchEntity,message];

  factory SearchState.init() => SearchState(
        status: DeafultBlocStatus.initial,
        searchEntity: SearchEntity(
          users: [],
          posts: [],
        ),
        message: '',
      );

  SearchState copyWith({
    DeafultBlocStatus? status,
    SearchEntity? searchEntity,
    String? message,
  }) {
    return SearchState(
      status: status ?? this.status,
      searchEntity: searchEntity ?? this.searchEntity,
      message: message ?? this.message,
    );
  }
}
