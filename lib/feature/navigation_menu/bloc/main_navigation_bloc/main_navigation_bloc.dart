import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_navigation_event.dart';
part 'main_navigation_state.dart';

class MainNavigationBloc extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(const MainNavigationIndexState(index: 0)) {
    on<MainNavigationEvent>((event, emit) {
      emit(MainNavigationIndexState(index: event.index));
    });
  }
}

