import 'dart:convert';

import 'package:rika_morti_mobile/core/local_source/local_data_source.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:rika_morti_mobile/features/home/data/models/get_characters_model.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalDataSource localDataSource;

  const HomeLocalDataSourceImpl({required this.localDataSource});

  @override
  Future<GetCharactersModel> getCharacters() async {
    final json = localDataSource.getCacheCharacters;
    return GetCharactersModel.fromJson(jsonDecode(json));
  }
}
