import 'package:rika_morti_mobile/core/either_dart/either.dart';
import 'package:rika_morti_mobile/core/error/failure.dart';
import 'package:rika_morti_mobile/core/usecases/use_case.dart';
import 'package:rika_morti_mobile/features/home/domain/entities/characters_entity.dart';
import 'package:rika_morti_mobile/features/home/domain/repositories/home_respository.dart';

class GetCharactersUseCase extends UseCase<CharactersEntity, ListParams> {
  final HomeRepository homeRepository;

  GetCharactersUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, CharactersEntity>> call(ListParams params) async {
    return await homeRepository.getCharacters(page: params.page);
  }
}
