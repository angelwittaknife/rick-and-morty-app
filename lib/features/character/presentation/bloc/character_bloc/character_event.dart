
part of 'character_bloc.dart';

class CharacterEvent extends Equatable {
  const CharacterEvent();
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharacterEvent {
  const LoadCharacters();

  @override
  List<Object?> get props => [];
}

class LoadMoreCharacters extends CharacterEvent {
  const LoadMoreCharacters();

  @override
  List<Object?> get props => [];
}

class WatchCharacters extends CharacterEvent {
  const WatchCharacters();

  @override
  List<Object?> get props => [];
}

class ToggleFavoriteStatus extends CharacterEvent {
  final int characterId;
  final bool isFavorite;

  const ToggleFavoriteStatus({
    required this.characterId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [characterId, isFavorite];
}



