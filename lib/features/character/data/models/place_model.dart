import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/features/character/domain/entities/place_entity.dart';

part 'place_model.g.dart';
@JsonSerializable()
class PlaceModel {
  const PlaceModel({required this.url, required this.name});
  final String url;
  final String name;
  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);
}

extension ModelXEntity on PlaceModel {
  PlaceEntity toEntity() => PlaceEntity(url: url, name: name);
}