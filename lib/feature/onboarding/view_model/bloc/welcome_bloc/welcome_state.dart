part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeState extends Equatable {}

final class WelcomeIndexState extends WelcomeState {
  final int index;

  WelcomeIndexState({required this.index});
  @override
  List<Object?> get props => [index];
}

final class WelcomeToHomeState extends WelcomeState {
  @override
  List<Object?> get props => [];
}
