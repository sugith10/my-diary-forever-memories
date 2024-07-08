import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/theme_model.dart';
import '../../repository/theme_repo.dart';

part 'theme_bloc_event.dart';
part 'theme_bloc_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  // Boolean variable to store the value of dark mode
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  int _value = 1;

  int get value => _value;

  final AppThemeRepo _appThemeRepo;

  // Initialize the ThemeBloc with the AppThemeRepo
  ThemeBloc(this._appThemeRepo) : super(ThemeInitial()) {
    // Listen for a ThemeGetEvent
    on<ThemeGetEvent>(_getTheme);
    // Listen for a ThemeSetEvent
    on<ThemeSetEvent>(_setTheme);

    // Add a ThemeGetEvent to the stream
    add(ThemeGetEvent());
  }

  // Handle a ThemeGetEvent
  _getTheme(ThemeGetEvent event, Emitter<ThemeState> emit) async {
    try {
      // Get the ThemeModel from the AppThemeRepo
      final ThemeModel themeModel = await _appThemeRepo.getThemePreference();
      // If the ThemeModel is ThemeModel.night
      if (themeModel == ThemeModel.night) {
        // Set the value of the dark mode boolean variable to true
        _isDarkMode = true;
        _value = 2;
        // Emit a ThemeCurrentState with ThemeModel.day
        emit(const ThemeCurrentState(ThemeModel.day));
      } else if (themeModel == ThemeModel.day) {
        // Set the value of the dark mode boolean variable to false
        _isDarkMode = false;
        _value = 1;
        // Emit a ThemeCurrentState with ThemeModel.day
        emit(const ThemeCurrentState(ThemeModel.day));
      }
    } catch (e) {
      // Log the error
      log(e.toString());
    }
  }

  // Handle a ThemeSetEvent
  _setTheme(ThemeSetEvent event, Emitter<ThemeState> emit) async {
    try {
      // If the ThemeModel is ThemeModel.day
      if (event.theme == ThemeModel.day) {
        // Set the value of the dark mode boolean variable to false
        _isDarkMode = false;
        _value = 1;
        // Set the ThemeModel preference in the AppThemeRepo
        log(event.theme.toString());
        emit(ThemeCurrentState(event.theme));
        await _appThemeRepo.setThemePreference(event.theme);
      } else if (event.theme == ThemeModel.night) {
        // Set the value of the dark mode boolean variable to true
        _isDarkMode = true;
        _value = 2;
        // Set the ThemeModel preference in the AppThemeRepo
        log(event.theme.toString());
        emit(ThemeCurrentState(event.theme));
        await _appThemeRepo.setThemePreference(event.theme);
      }
    } catch (e) {
      // Log the error
      log(e.toString());
    }
  }
}
