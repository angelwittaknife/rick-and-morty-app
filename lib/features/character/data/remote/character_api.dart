import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/data/models/character_model.dart';
import 'package:dio/dio.dart';

abstract interface class CharacterApi {
  Future<Either<Failure, List<CharacterModel>>> getAllCharacters();
}

class CharacterApiImpl implements CharacterApi {
  @override
  Future<Either<Failure, List<CharacterModel>>> getAllCharacters() async {
    try {
      //await dotenv.load();
      final String url = 'https://rickandmortyapi.com/api/character';
      //dotenv.env["API_URL"] ??
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        final results = response.data['results'] as List<dynamic>;
        final characters = results
            .map((json) => CharacterModel.fromJson(json))
            .toList();
        return Right(characters);
      } else {
        return Left(
          ServerFailure(
            "Ошибка сервера: ${response.statusCode} ${response.statusMessage}",
          ),
        );
      }
    } catch (e) {
      return Left(ServerFailure("Ошибка сервера: $e"));
    }
  }
}
