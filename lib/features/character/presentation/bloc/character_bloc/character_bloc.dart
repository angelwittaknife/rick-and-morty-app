import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/usecases/toggle_fav_status_usecase.dart';
import 'package:rick_and_morty/features/character/domain/usecases/use_case.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_all_characters_usecase.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final UseCase toggleFavStatusUsecase =
      sl<ToggleFavStatusUsecase>();
  final WatchAllCharactersUsecase watchAllCharactersUsecase =
      sl<WatchAllCharactersUsecase>();

  CharacterBloc() : super(CharactersLoading()) {
    on<LoadCharacters>(_watchCharacters);
    on<ToggleFavoriteStatus>(_toggleFavoriteStatus);
  }

  Future<void> _watchCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {

    await emit.forEach<Either<Failure, List<CharacterEntity>>>(
      watchAllCharactersUsecase(),
      onData: (either) => either.fold(
        (failure) => CharactersError(failure.message),
        (list) => CharactersLoaded(list),
      ),
      onError: (_, __) => const CharactersError('Ошибка загрузки потока'),
    );
  }

  Future<void> _toggleFavoriteStatus(
    ToggleFavoriteStatus event,
    Emitter<CharacterState> emit,
  ) async {
    await toggleFavStatusUsecase(
      param: ToggleFavStatusParams(
        characterId: event.characterId,
        isFavorite: event.isFavorite,
      ),
    );
  }
}
