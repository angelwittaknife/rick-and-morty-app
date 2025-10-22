

part of 'character_bloc.dart';

class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object?> get props => [];
}

class CharactersErrorState extends CharacterState {
  final String message;
  const CharactersErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class CharactersLoadingState extends CharacterState {
  const CharactersLoadingState();

  @override
  List<Object?> get props => [];
}

class CharactersLoadedState extends CharacterState {
  final List<CharacterEntity> characters;
  const CharactersLoadedState(this.characters);

  @override
  List<Object?> get props => [characters];
}