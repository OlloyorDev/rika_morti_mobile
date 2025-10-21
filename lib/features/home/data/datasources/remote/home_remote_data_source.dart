import 'package:rika_morti_mobile/features/home/data/models/get_characters_model.dart';

abstract class HomeRemoteDataSource {
  Future<GetCharactersModel> getCharacters({int page = 1});
}
