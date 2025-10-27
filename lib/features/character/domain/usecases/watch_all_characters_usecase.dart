import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_usecase.dart';

class WatchAllCharactersUsecase extends WatchUseCase<List<CharacterEntity>, void> {
  final CharacterRepository repository;

  WatchAllCharactersUsecase(this.repository);

  @override
  Stream<Either<Failure, List<CharacterEntity>>> call({param}) {
    return repository.watchCharacters();
  }

}