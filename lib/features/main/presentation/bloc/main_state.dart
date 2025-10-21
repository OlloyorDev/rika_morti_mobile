part of 'main_bloc.dart';

class MainState extends Equatable {
  final MainScreens currentScreen;

  const MainState({this.currentScreen = MainScreens.home});

  MainState copyWith({MainScreens? currentScreen}) =>
      MainState(currentScreen: currentScreen ?? this.currentScreen);

  @override
  List<Object?> get props => [currentScreen];
}

enum MainScreens { home, favorites }

extension MainScreensX on MainScreens {
  bool get home => this == MainScreens.home;

  bool get favorites => this == MainScreens.favorites;
}
