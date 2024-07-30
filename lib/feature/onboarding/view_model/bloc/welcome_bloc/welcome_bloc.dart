import 'package:diary/feature/auth/model/app_preference_model/app_preference_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/app_pref_db_controller.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  int _index = 0;
  int get index => _index;
  WelcomeBloc() : super(WelcomeIndexState(index: 0)) {
    on<WelcomeIndexEvent>(_welecomeIndex);
    on<WelcomeToHomeEvent>(_toHome);
  }

  _welecomeIndex(WelcomeIndexEvent event, Emitter<WelcomeState> emit) {
    _index = event.index;
    emit(WelcomeIndexState(index: event.index));
  }

  _toHome(WelcomeToHomeEvent event, Emitter<WelcomeState> emit) async {
    await AppPrefRepo().showwelcome(AppPreferenceModel(showwelcome: false));
    emit(WelcomeToHomeState());
  }
}
