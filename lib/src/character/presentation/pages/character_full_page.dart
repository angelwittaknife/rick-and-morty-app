import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';

class CharacterFullPage extends StatelessWidget {
  final CharacterEntity character;

  const CharacterFullPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Character Full Page: ${character.name}'));
  }
}
