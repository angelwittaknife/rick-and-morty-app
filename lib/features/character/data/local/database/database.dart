import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty/features/character/data/local/database/daos/character_dao.dart';
import 'package:rick_and_morty/features/character/data/local/database/daos/place_dao.dart';
import 'package:rick_and_morty/features/character/data/local/database/tables/characters.dart';
import 'package:rick_and_morty/features/character/data/local/database/tables/places.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [Places, Characters],
  daos: [PlaceDao, CharacterDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'rick_and_morty_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
