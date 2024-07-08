part of 'theme_bloc_bloc.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();
  
  @override
  List<Object> get props => [];
}

final class ThemeInitial extends ThemeState{}

final class ThemeCurrentState extends ThemeState {
  final ThemeModel theme;

  const ThemeCurrentState(this.theme);

  @override
  List<Object> get props => [theme];
}

