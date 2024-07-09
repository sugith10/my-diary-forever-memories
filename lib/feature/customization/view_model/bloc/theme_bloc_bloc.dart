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

  ThemeBloc(this._appThemeRepo) : super(ThemeInitial()) {
    on<ThemeGetEvent>(_getTheme);

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

        emit(const ThemeCurrentState(ThemeModel.night));
      } else if (themeModel == ThemeModel.day) {
        // Set the value of the dark mode boolean variable to false
        _isDarkMode = false;
        _value = 1;

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
      if (event.theme == ThemeModel.day && _isDarkMode != false) {
        // Set the value of the dark mode boolean variable to false
        _isDarkMode = false;
        _value = 1;
        // Set the ThemeModel preference in the AppThemeRepo

        emit(ThemeCurrentState(event.theme));
        await _appThemeRepo.setThemePreference(event.theme);
      } else if (event.theme == ThemeModel.night && _isDarkMode != true) {
        // Set the value of the dark mode boolean variable to true
        _isDarkMode = true;
        _value = 2;
        // Set the ThemeModel preference in the AppThemeRepo

        emit(ThemeCurrentState(event.theme));
        await _appThemeRepo.setThemePreference(event.theme);
      }
    } catch (e) {
      // Log the error
      log(e.toString());
    }
  }
}
