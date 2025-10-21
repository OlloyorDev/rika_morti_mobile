import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rika_morti_mobile/core/local_source/local_data_source.dart';
import 'package:rika_morti_mobile/core/streams/favorite_stream_manager.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final LocalDataSource localDataSource;
  final FavoriteStreamManager favoriteStreamManager;

  FavoritesBloc({
    required this.localDataSource,
    required this.favoriteStreamManager,
  }) : super(FavoritesState()) {
    favoriteStreamManager.onListen((v) => add(AddAndRemoveFavoriteEvent(v)));
    on<LoadFavoritesEvent>(_loadFavoritesEvent);
    on<AddAndRemoveFavoriteEvent>(_addAndRemoveFavoriteEvent);
  }

  void _loadFavoritesEvent(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) {
    final cachedData = localDataSource.getCacheFavorites;
    final favorites = <Character>[];
    final json = jsonDecode(cachedData ?? '[]') as List<dynamic>;
    favorites.addAll(
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
    emit(state.copyWith(favorites: favorites));
  }

  void _addAndRemoveFavoriteEvent(
    AddAndRemoveFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) {
    final currentFavorites = List.of(state.favorites);
    if (currentFavorites.contains(event.v)) {
      currentFavorites.remove(event.v);
    } else {
      currentFavorites.add(event.v);
    }
    final json = currentFavorites.map((e) => e.toJson()).toList();
    localDataSource.cacheFavorites(jsonEncode(json));
    emit(state.copyWith(favorites: List.from(currentFavorites)));
  }
}
