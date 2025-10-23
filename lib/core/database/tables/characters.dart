import 'package:drift/drift.dart';
import 'package:rick_and_morty/core/database/tables/places.dart';

@DataClassName('Character')
class Characters extends Table {
  IntColumn get id => integer()();
  BoolColumn get isFavorite => boolean()();
  TextColumn get name => text().withLength(min: 0, max: 256)();
  TextColumn get status => text().withLength(min: 0, max: 256)();
  TextColumn get species => text().withLength(min: 0, max: 256)();
  TextColumn get type => text().withLength(min: 0, max: 256)();
  TextColumn get gender => text().withLength(min: 0, max: 256)();
  TextColumn get image => text().withLength(min: 0, max: 256)();
  TextColumn get url => text().withLength(min: 0, max: 256)();

  @ReferenceName('originRefs')
  IntColumn get fkOrigin => integer().references(Places, #id)();

  @ReferenceName('locationRefs')
  IntColumn get fkLocation => integer().references(Places, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
