import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/character/domain/usecases/use_case.dart';

class ToggleFavStatusUsecase extends UseCase<void, ToggleFavStatusParams?> {
  final CharacterRepository repository;

  ToggleFavStatusUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call({ToggleFavStatusParams? param}) {
    if (param == null) {
      return Future.value(
        Left(CharacterFailure('Параметры не могут быть пустыми')),
      );
    }
    return repository.toggleFavoriteStatus(param.characterId, param.isFavorite);
  }
}

class ToggleFavStatusParams {
  final int characterId;
  final bool isFavorite;

  ToggleFavStatusParams({required this.characterId, required this.isFavorite});
}
