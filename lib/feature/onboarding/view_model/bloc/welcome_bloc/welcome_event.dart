part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeEvent {}

final class WelcomeIndexEvent extends WelcomeEvent {
  final int index;
  WelcomeIndexEvent(this.index);
}

final class WelcomeToHomeEvent extends WelcomeEvent {}
