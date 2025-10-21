import 'dart:async';

import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';

class FavoriteStreamManager {
  final StreamController<Character> favoriteController =
      StreamController<Character>.broadcast();

  void onListen(void Function(Character) onData) {
    favoriteController.stream.listen(onData);
  }

  void addFavorite(Character character) {
    favoriteController.sink.add(character);
  }

  void dispose() {
    favoriteController.close();
  }

  StreamController<Character> get controller => favoriteController;
}
