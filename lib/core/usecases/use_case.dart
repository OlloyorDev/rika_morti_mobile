import 'package:rika_morti_mobile/core/either_dart/either.dart';
import 'package:rika_morti_mobile/core/error/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

class ListParams {
  final int page;

  ListParams({required this.page});
}

class CacheParams {
  final bool isCache;

  CacheParams({required this.isCache});
}
