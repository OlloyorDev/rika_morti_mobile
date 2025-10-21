import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rika_morti_mobile/core/constants/api_constants.dart';
import 'package:rika_morti_mobile/core/error/exceptions.dart';
import 'package:rika_morti_mobile/core/local_source/local_data_source.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:rika_morti_mobile/features/home/data/models/get_characters_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  final LocalDataSource localDataSource;

  HomeRemoteDataSourceImpl({required this.dio, required this.localDataSource});

  @override
  Future<GetCharactersModel> getCharacters({int page = 1}) async {
    try {
      final response = await dio.get(
        ApiConstants.getCharacters,
        queryParameters: {'page': page},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonEncode(response.data);
        localDataSource.cacheCharacters(json);
        return GetCharactersModel.fromJson(response.data);
      }
      throw ServerException.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromJson(e.response?.data);
    } on FormatException {
      throw ServerException(message: "Something went wrong");
    }
  }
}
