import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/core/local_source/local_data_source.dart';
import 'package:rika_morti_mobile/core/statuses/statuses.dart';
import 'package:rika_morti_mobile/core/streams/favorite_stream_manager.dart';
import 'package:rika_morti_mobile/core/usecases/use_case.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';
import 'package:rika_morti_mobile/features/home/domain/usecases/get_characters_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCharactersUseCase getCharactersUseCase;
  final LocalDataSource localDataSource;
  final FavoriteStreamManager favoriteStreamManager;

  HomeBloc({
    required this.getCharactersUseCase,
    required this.localDataSource,
    required this.favoriteStreamManager,
  }) : super(HomeState()) {
    favoriteStreamManager.onListen((v) => add(AddAndRemoveFavoriteEvent(v)));
    on<GetCharactersEvent>(_getCharacters);
    on<AddAndRemoveFavoriteEvent>(_addFavorite);
  }

  Future<void> _getCharacters(
    GetCharactersEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.paginationEnd && state.paginationStatus.loading) return;

    event.fromPagination
        ? emit(state.copyWith(paginationStatus: GetStatus.loading))
        : emit(state.copyWith(getStatus: GetStatus.loading));

    List<Character>? characterList;
    event.fromPagination
        ? characterList = List.of(state.characters?.list ?? [])
        : characterList = <Character>[];
    final characters = await getCharactersUseCase.call(
      ListParams(page: (state.characters?.list.length ?? 0) ~/ 20 + 1),
    );
    characters.fold(
      (fail) {
        // Handle failure case
      },
      (success) {
        final cachedData = localDataSource.getCacheFavorites;
        final list = <Character>[];
        final json = jsonDecode(cachedData ?? '[]') as List<dynamic>;
        list.addAll(
          json
              .map<Character>(
                (e) => Character(
                  id: e['id'],
                  name: e['name'],
                  status: e['status'],
                  species: e['species'],
                  location: e['location'],
                  image: e['image'],
                ),
              )
              .toList(),
        );
        characterList?.addAll(success.list);
        emit(
          state.copyWith(
            characters: CharactersEntity(list: characterList ?? []),
            favorites: list,
            paginationEnd: success.list.length < 20,
            getStatus: GetStatus.success,
          ),
        );
      },
    );
  }

  void _addFavorite(AddAndRemoveFavoriteEvent event, Emitter<HomeState> emit) {
    final currentFavorites = List.of(state.favorites);

    if (currentFavorites.any((c) => c.id == event.character.id)) {
      currentFavorites.removeWhere((c) => c.id == event.character.id);
    } else {
      currentFavorites.add(event.character);
    }

    final json = jsonEncode(currentFavorites.map((e) => e.toJson()).toList());
    localDataSource.cacheFavorites(json);
    emit(state.copyWith(favorites: List.from(currentFavorites)));
  }
}
