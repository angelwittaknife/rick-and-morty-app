import 'package:drift/drift.dart';
import 'package:rick_and_morty/core/database/database.dart';

@DataClassName('Place')
@UseRowClass(Place)
class Places extends Table {
  IntColumn get id => integer()();
  TextColumn get url => text().withLength(min: 0, max: 255)();
  TextColumn get name => text().withLength(min: 0, max: 255)();
  @override
  Set<Column> get primaryKey => {id};
}
