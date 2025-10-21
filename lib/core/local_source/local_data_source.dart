import 'package:hive/hive.dart';
import 'package:rika_morti_mobile/core/local_source/caches_box_names.dart';

class LocalDataSource {
  final Box<dynamic> box;

  const LocalDataSource({required this.box});

  void cacheCharacters(String value) {
    box.put(CachesBoxNames.characterList, value);
  }

  String get getCacheCharacters =>
      box.get(CachesBoxNames.characterList, defaultValue: null);

  void cacheFavorites(String value) {
    box.put(CachesBoxNames.favoritesList, value);
  }

  dynamic get getCacheFavorites =>
      box.get(CachesBoxNames.favoritesList, defaultValue: null);

  Future<void> clearAllCaches() async {
    await box.clear();
  }
}
