part of 'main_navigation_bloc.dart';

sealed class MainNavigationState extends Equatable {
  const MainNavigationState();
  
  @override
  List<Object> get props => [];
}

final class MainNavigationIndexState extends MainNavigationState {
  final int index;

  const MainNavigationIndexState({required this.index});

  @override
  List<Object> get props => [index];
}
