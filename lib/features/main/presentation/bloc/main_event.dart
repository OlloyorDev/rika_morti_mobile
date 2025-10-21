part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();
}


class MainScreenChange extends MainEvent {
  final MainScreens v;
  const MainScreenChange(this.v);

  @override
  List<Object?> get props => [v];
}