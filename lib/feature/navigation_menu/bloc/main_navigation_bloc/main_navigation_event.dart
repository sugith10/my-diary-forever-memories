part of 'main_navigation_bloc.dart';

final class MainNavigationEvent extends Equatable {
  final int index;
  const MainNavigationEvent(this.index);

  @override
  List<Object> get props => [index];
}
