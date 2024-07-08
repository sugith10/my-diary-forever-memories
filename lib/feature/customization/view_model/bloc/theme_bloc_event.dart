part of 'theme_bloc_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeSetEvent extends ThemeEvent {
  final ThemeModel theme;

  const ThemeSetEvent({required this.theme});

  @override
  List<Object> get props => [theme];
}

class ThemeGetEvent extends ThemeEvent{
  
}