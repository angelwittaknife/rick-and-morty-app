
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/character/domain/usecases/no_params.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_usecase.dart';

class WatchFavCharactersUsecase extends WatchUseCase <List<CharacterEntity>, NoParams> {
  final CharacterRepository _repository;
  const WatchFavCharactersUsecase(CharacterRepository repository) : _repository = repository;

  @override
  Stream<Either<Failure, List<CharacterEntity>>> call({NoParams? param}) {
    return _repository.watchFavoriteCharacters();
  }
} 