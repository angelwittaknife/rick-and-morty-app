
part of 'fav_character_bloc.dart';

class FavCharacterEvent extends Equatable {
  const FavCharacterEvent();
  @override
  List<Object?> get props => [];
}


class WatchFavCharacters extends FavCharacterEvent {
  const WatchFavCharacters();

  @override
  List<Object?> get props => [];
}

class ToggleFavCharacterStatus extends FavCharacterEvent {
  final int characterId;
  final bool isFavorite;

  const ToggleFavCharacterStatus({
    required this.characterId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [characterId, isFavorite];
}