import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/character/presentation/bloc/fav_character_bloc/fav_character_bloc.dart';
import 'package:rick_and_morty/features/character/presentation/widgets/character_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavCharacterBloc()..add(WatchFavCharacters()),
      child: BlocBuilder<FavCharacterBloc, FavCharacterState>(
        builder: (context, state) {
          if (state is FavCharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavCharactersLoaded) {
            final characters = state.characters;
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: characters[index],
                  onTap: (character) =>
                      context.push('/home/character', extra: character),
                  onFavoriteTap: (character) {
                    context.read<FavCharacterBloc>().add(
                      ToggleFavCharacterStatus(
                        characterId: character.id,
                        isFavorite: !character.isFavorite!,
                      ),
                    );
                  }
                );
              },
            );
          } else if (state is FavCharactersError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
