import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/character/presentation/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty/features/character/presentation/widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc()..add(LoadCharacters()),
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
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
                    context.read<CharacterBloc>().add(
                      ToggleFavoriteStatus(
                        characterId: character.id,
                        isFavorite: !character.isFavorite!,
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
