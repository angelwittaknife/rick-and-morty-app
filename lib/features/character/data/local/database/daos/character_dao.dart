import 'package:drift/drift.dart';
import 'package:rick_and_morty/features/character/data/local/database/database.dart';
import 'package:rick_and_morty/features/character/data/local/database/tables/characters.dart';
import 'package:rick_and_morty/features/character/data/models/character_model.dart';

part 'character_dao.g.dart';

@DriftAccessor(tables: [Characters])
class CharacterDao extends DatabaseAccessor<AppDatabase>
    with _$CharacterDaoMixin {
  CharacterDao(super.db);

  Future<List<Character>> getAllCharacters() => select(characters).get();

  Future<Character> getCharacterById(int id) =>
      (select(characters)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> insertCharacter(CharacterModel character) async {
    final originId = await db.placeDao.insertPlace(
      PlacesCompanion.insert(
        name: character.origin.name,
        url: character.origin.url,
      ),
    );

    final locationId = await db.placeDao.insertPlace(
      PlacesCompanion.insert(
        name: character.location.name,
        url: character.location.url,
      ),
    );
    return await into(characters).insertOnConflictUpdate(
      CharactersCompanion.insert(
        isFavorite: false,
        id: Value(character.id),
        name: character.name,
        status: character.status,
        species: character.species,
        type: character.type,
        gender: character.gender,
        image: character.image,
        url: character.url,
        fkOrigin: originId,
        fkLocation: locationId,
      ),
    );
  }

  Future<void> insertCharactersBulk(List<CharacterModel> models) async {
    await transaction(() async {
      for (final model in models) {
        final originId = await db.placeDao.insertPlace(
          PlacesCompanion.insert(
            name: model.origin.name,
            url: model.origin.url,
          ),
        );

        final locationId = await db.placeDao.insertPlace(
          PlacesCompanion.insert(
            name: model.location.name,
            url: model.location.url,
          ),
        );

        await into(characters).insertOnConflictUpdate(
          CharactersCompanion.insert(
            isFavorite: false,
            id: Value(model.id),
            name: model.name,
            status: model.status,
            species: model.species,
            type: model.type,
            gender: model.gender,
            image: model.image,
            url: model.url,
            fkOrigin: originId,
            fkLocation: locationId,
          ),
        );
      }
    });
  }

  Future<void> updateCharacterFavorite(int id, bool isFavorite) async {
    await transaction(() async {
      await (update(characters)..where((tbl) => tbl.id.equals(id))).write(
        CharactersCompanion(isFavorite: Value(isFavorite)),
      );
    });
  }

  Future<void> deleteCharacter(Character character) => (delete(
    characters,
  )..where((tbl) => tbl.name.equals(character.name))).go();

  Stream<List<Character>> watchCharacters() => select(characters).watch();

  Stream<List<Character>> watchFavoriteCharacters() {
    final query = (select(characters)
      ..where((tbl) => tbl.isFavorite.equals(true)));
    return query.watch();
  }
}
