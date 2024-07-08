import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/repository/app_pref_db_controller.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashMoveEvent>(_onMove);
    add(SplashMoveEvent());
  }

  _onMove(SplashMoveEvent event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() async {
      final welcomeStatus =
          await AppPrefRepo().getwelcomeStatus();

      if (welcomeStatus == null) {
        emit(SplashTowelcomeState());
      } else {
        emit(SplashToHomeState());
      }
    });
  }
}
