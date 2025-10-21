import 'package:rika_morti_mobile/core/either_dart/either.dart';
import 'package:rika_morti_mobile/core/error/failure.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CharactersEntity>> getCharacters({required int page});
}
