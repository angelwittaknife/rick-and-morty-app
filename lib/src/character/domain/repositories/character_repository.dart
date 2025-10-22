import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';

abstract interface class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters();
}
