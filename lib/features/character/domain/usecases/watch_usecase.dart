import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';

abstract class WatchUseCase<T, Params> {
  const WatchUseCase();
  Stream<Either<Failure, T>> call({Params? param});
  
}
