import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/src/character/data/models/character_model.dart';
import 'package:rick_and_morty/src/character/data/services/character_api_service.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/src/character/domain/repositories/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacters() async {
    final result = await sl<CharacterApiService>().getAllCharacters();
    return result.fold(
      (failure) => Left(failure),
      (models) => Right(models.map((model) => model.toEntity()).toList()),
    );
  }
}
