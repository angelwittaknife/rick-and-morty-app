import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';

abstract interface class CharacterRepository {
  Stream<Either<Failure, List<CharacterEntity>>> watchCharacters();
  Stream<Either<Failure, List<CharacterEntity>>> watchFavoriteCharacters();
  Future<Either<Failure, void>> toggleFavoriteStatus(int characterId,bool isFavorite);
}
