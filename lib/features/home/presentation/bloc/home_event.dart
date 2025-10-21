part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetCharactersEvent extends HomeEvent {
  final bool fromPagination;

  const GetCharactersEvent({this.fromPagination = false});

  @override
  List<Object?> get props => [fromPagination];
}

class AddAndRemoveFavoriteEvent extends HomeEvent {
  final Character character;

  const AddAndRemoveFavoriteEvent(this.character);

  @override
  List<Object?> get props => [character];
}
