part of 'fav_character_bloc.dart';

class FavCharacterState extends Equatable {
  const FavCharacterState();
  @override
  List<Object?> get props => [];
}
class FavCharactersError extends FavCharacterState {
  final String message;
  const FavCharactersError(this.message);

  @override
  List<Object?> get props => [message];
}
class FavCharactersLoading extends FavCharacterState {
  const FavCharactersLoading();

  @override
  List<Object?> get props => [];
}
class FavCharactersLoaded extends FavCharacterState {
  final List<CharacterEntity> characters;
  const FavCharactersLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}