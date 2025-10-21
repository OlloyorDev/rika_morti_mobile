part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();
}

class LoadFavoritesEvent extends FavoritesEvent {
  const LoadFavoritesEvent();

  @override
  List<Object?> get props => [];
}

class AddAndRemoveFavoriteEvent extends FavoritesEvent {
  final Character v;

  const AddAndRemoveFavoriteEvent(this.v);

  @override
  List<Object?> get props => [v];
}
