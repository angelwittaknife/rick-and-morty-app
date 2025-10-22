import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/src/character/data/repository/character_repository.dart';
import 'package:rick_and_morty/src/character/data/services/character_api_service.dart';
import 'package:rick_and_morty/src/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/src/character/domain/usecases/get_all_characters_usecase.dart';


final sl = GetIt.instance;

void init() {
  sl
  //services
  ..registerLazySingleton<CharacterApiService>(CharacterApiServiceImpl.new)
  //repositories
  ..registerLazySingleton<CharacterRepository>(CharacterRepositoryImpl.new)
  //usecases
  ..registerLazySingleton<GetAllCharactersUsecase>(GetAllCharactersUsecase.new)
  
  
  ;
  
}
