import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/src/character/domain/usecases/get_all_characters_usecase.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(CharactersLoadingState()) {
    on<LoadCharactersEvent>(_loadCharacters);
  }

  Future<void> _loadCharacters(
    LoadCharactersEvent event,
    Emitter<CharacterState> emit,
  ) async {
    final characters = await sl<GetAllCharactersUsecase>()();
    characters.fold(
      (failure) =>
          emit(CharactersErrorState(message: failure.message)),
      (characterList) => emit(CharactersLoadedState(characterList)),
    );
  }
}
