import 'package:rick_and_morty/src/character/domain/entities/place_entity.dart';

class CharacterEntity {
  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.url,
    required this.isFavorite,
  });

  final int id;
  final String url;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final PlaceEntity origin;
  final PlaceEntity location;
  final bool? isFavorite;
}
