import 'package:drift/drift.dart';
import 'package:rick_and_morty/core/database/database.dart';
import 'package:rick_and_morty/core/database/tables/places.dart';

part 'place_dao.g.dart';

@DriftAccessor(tables:[Places])
class PlaceDao extends DatabaseAccessor<AppDatabase> with _$PlaceDaoMixin {
  PlaceDao(super.db);

  Future<List<Place>> getAllPlaces() => select(places).get(); 

  Future<Place> getPlaceById(int id) => (select(places)..where((tbl)=>tbl.id.equals(id))).getSingle();

  Future<int> insertPlace(PlacesCompanion place) async {
    return await into(places).insertOnConflictUpdate(place);
  }

  Future<void> updatePlace(Place place)=>update(places).replace(place);

  Future<void> deletePlace(Place place) => (delete(places)..where((tbl) => tbl.name.equals(place.name))).go();

  Stream<List<Place>> watchPlaces() => select(places).watch();
 

   
}