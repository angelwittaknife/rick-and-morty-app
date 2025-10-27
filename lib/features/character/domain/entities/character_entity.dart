import 'package:rick_and_morty/features/character/data/local/database/database.dart';
import 'package:rick_and_morty/features/character/domain/entities/place_entity.dart';

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

  CharacterEntity copyWith({
    int? id,
    String? url,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    String? image,
    PlaceEntity? origin,
    PlaceEntity? location,
    bool? isFavorite,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      type: type ?? this.type,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

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
  final bool isFavorite = false;

  static Future<CharacterEntity> fromTable(Character character, Place origin, Place location) async {
    return CharacterEntity(
      id: character.id,
      name: character.name,
      status: character.status,
      species: character.species,
      type: character.type,
      gender: character.gender,
      image: character.image,
      url: character.url,
      isFavorite: character.isFavorite,
      origin: PlaceEntity(name: origin.name, url: origin.url),
      location: PlaceEntity(name: location.name, url: location.url),
    );
  }
}
