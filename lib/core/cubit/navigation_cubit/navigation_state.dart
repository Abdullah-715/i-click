part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int index;
  const NavigationState({required this.index});
  factory NavigationState.intial() {
    return const NavigationState(
      index: 0,
    );
  }
  @override
  List<Object?> get props => [index];

  NavigationState copyWith({
    int? index,
  }) {
    return NavigationState(
      index: index ?? this.index,
    );
  }
}
