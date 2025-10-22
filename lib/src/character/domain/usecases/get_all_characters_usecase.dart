import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/src/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/src/character/domain/usecases/no_params.dart';
import 'package:rick_and_morty/src/character/domain/usecases/use_case.dart';

class GetAllCharactersUsecase extends UseCase<Future<Either<Failure,List<CharacterEntity>>>, NoParams> {
  @override
  call({param}) => sl<CharacterRepository>().getAllCharacters();
} 