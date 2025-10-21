part of 'home_bloc.dart';

class HomeState extends Equatable {
  final GetStatus getStatus;
  final GetStatus paginationStatus;
  final bool paginationEnd;
  final CharactersEntity? characters;
  final List<Character> favorites;

  const HomeState({
    this.getStatus = GetStatus.initial,
    this.paginationStatus = GetStatus.initial,
    this.paginationEnd = false,
    this.characters,
    this.favorites = const [],
  });

  HomeState copyWith({
    GetStatus? getStatus,
    GetStatus? paginationStatus,
    bool? paginationEnd,
    CharactersEntity? characters,
    List<Character>? favorites,
  }) => HomeState(
    getStatus: getStatus ?? this.getStatus,
    paginationStatus: paginationStatus ?? GetStatus.initial,
    paginationEnd: paginationEnd ?? false,
    characters: characters ?? this.characters,
    favorites: favorites ?? this.favorites,
  );

  @override
  List<Object?> get props => [
    getStatus,
    paginationStatus,
    paginationEnd,
    characters,
    favorites,
  ];
}
