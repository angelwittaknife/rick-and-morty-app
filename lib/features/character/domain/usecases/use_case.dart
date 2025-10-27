
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';

abstract class UseCase<T, Params> {
  const UseCase();
  Future<Either<Failure, T>> call({Params? param});
}
