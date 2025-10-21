import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<MainScreenChange>(_mainScreenChange);
  }

  void _mainScreenChange(MainScreenChange event, Emitter<MainState> emit) {
    emit(state.copyWith(currentScreen: event.v));
  }
}
