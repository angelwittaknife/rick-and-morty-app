import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/src/character/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/src/character/presentation/widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc()..add(LoadCharactersEvent()),
      child: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharactersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoadedState) {
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
                return CharacterCard(character: characters[index]);
              },
            );
          } else if (state is CharactersErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
