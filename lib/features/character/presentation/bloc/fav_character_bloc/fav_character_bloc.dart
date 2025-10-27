import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/usecases/toggle_fav_status_usecase.dart';
import 'package:rick_and_morty/features/character/domain/usecases/watch_fav_characters_usecase.dart';

part 'fav_character_event.dart';
part 'fav_character_state.dart';

class FavCharacterBloc extends Bloc<FavCharacterEvent, FavCharacterState> {
  final ToggleFavStatusUsecase _toggleFavStatusUsecase =
      sl<ToggleFavStatusUsecase>();
  final WatchFavCharactersUsecase _watchFavCharactersUsecase =
      sl<WatchFavCharactersUsecase>();
  FavCharacterBloc() : super(FavCharactersLoading()) {
    on<WatchFavCharacters>(_onWatchCharacters);
    on<ToggleFavCharacterStatus>(_onToggleFavoriteStatus);
  }

  Future<void> _onWatchCharacters(
    WatchFavCharacters event,
    Emitter<FavCharacterState> emit,
  ) async {
    emit(FavCharactersLoading());

    await emit.forEach<Either<Failure, List<CharacterEntity>>>(
      _watchFavCharactersUsecase(),
      onData: (either) => either.fold(
        (failure) => FavCharactersError(failure.message),
        (list) => FavCharactersLoaded(list),
      ),
      onError: (_, _) => const FavCharactersError('Ошибка загрузки потока'),
    );
  }

  Future<void> _onToggleFavoriteStatus(
    ToggleFavCharacterStatus event,
    Emitter<FavCharacterState> emit,
  ) async {
    await _toggleFavStatusUsecase(
      param: ToggleFavStatusParams(
        characterId: event.characterId,
        isFavorite: event.isFavorite,
      ),
    );
  }
}
