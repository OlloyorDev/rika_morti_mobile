part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<Character> favorites;

  const FavoritesState({this.favorites = const []});

  FavoritesState copyWith({List<Character>? favorites}) =>
      FavoritesState(favorites: favorites ?? this.favorites);

  @override
  List<Object?> get props => [favorites];
}

enum FavoriteSortType { name, status, species }

extension FavoriteSortTypeX on FavoriteSortType {
  bool get name => this == FavoriteSortType.name;

  bool get status => this == FavoriteSortType.status;

  bool get species => this == FavoriteSortType.species;

  String get sortName {
    switch (this) {
      case FavoriteSortType.name:
        return 'Name';
      case FavoriteSortType.status:
        return 'Status';
      case FavoriteSortType.species:
        return 'Species';
    }
  }
}
