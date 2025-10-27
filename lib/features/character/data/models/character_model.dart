import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/character/data/models/place_model.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  const CharacterModel({
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
  });

  final int id;
  final String url;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final PlaceModel origin;
  final PlaceModel location;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

extension CharacterModelXCharacterEntity on CharacterModel {
  CharacterEntity toEntity() => CharacterEntity(
    id: id,
    name: name,
    status: status,
    species: species,
    type: type,
    gender: gender,
    origin: origin.toEntity(),
    location: location.toEntity(),
    image: image,
    url: url,
    isFavorite: false,
  );
}
