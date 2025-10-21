import 'package:rika_morti_mobile/core/either_dart/either.dart';
import 'package:rika_morti_mobile/core/error/failure.dart';
import 'package:rika_morti_mobile/core/network/network_info.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/local/home_local_data_source.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';
import 'package:rika_morti_mobile/features/home/domain/repositories/home_respository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, CharactersEntity>> getCharacters({
    required int page,
  }) async {
    if (await networkInfo.isConnected) {
      final data = await homeRemoteDataSource.getCharacters(page: page);
      return Right(data.toEntity);
    } else {
      final data = await homeLocalDataSource.getCharacters();
      return Right(data.toEntity);
    }
  }
}
