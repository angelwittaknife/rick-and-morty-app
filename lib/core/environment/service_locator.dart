import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/features/character/data/local/database/database.dart';
import 'package:rick_and_morty/features/character/data/repository/character_repository.dart';
import 'package:rick_and_morty/features/character/data/remote/character_api.dart';
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_all_characters_usecase.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_fav_characters_usecase.dart';
import 'package:rick_and_morty/features/character/domain/usecases/toggle_fav_status_usecase.dart';

final sl = GetIt.instance;

void init() {
  sl
    //datasources
    ..registerLazySingleton<CharacterApi>(CharacterApiImpl.new)
    ..registerLazySingleton<AppDatabase>(AppDatabase.new)
    //repositories
    ..registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(sl(), sl()),
    )
    //usecases

    ..registerLazySingleton<WatchFavCharactersUsecase>(
      () => WatchFavCharactersUsecase(sl()),
    )
    ..registerLazySingleton<ToggleFavStatusUsecase>(
      () => ToggleFavStatusUsecase(sl()),
    )
    ..registerLazySingleton<WatchAllCharactersUsecase>(
      () => WatchAllCharactersUsecase(sl()),
    );
}
