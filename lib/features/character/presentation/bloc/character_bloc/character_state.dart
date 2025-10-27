part of 'character_bloc.dart';

class CharacterState extends Equatable {
  const CharacterState();
  @override
  List<Object?> get props => [];
}

class CharactersError extends CharacterState {
  final String message;
  const CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}

class CharactersLoading extends CharacterState {
  final List<CharacterEntity> characters;
  final bool isFirstLoad;

  const CharactersLoading({
    this.characters = const [],
    this.isFirstLoad = true,
  });

  @override
  List<Object?> get props => [characters, isFirstLoad];
}

class CharactersLoaded extends CharacterState {
  final List<CharacterEntity> characters;
  final bool hasReachedEnd;
  final int currentPage;

  const CharactersLoaded(
    this.characters, {
    this.hasReachedEnd = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [characters, hasReachedEnd, currentPage];

  CharactersLoaded copyWith({
    List<CharacterEntity>? characters,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return CharactersLoaded(
      characters ?? this.characters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
