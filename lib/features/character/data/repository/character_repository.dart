import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/errors/failures.dart';
import 'package:rick_and_morty/features/character/data/local/database/database.dart';
import 'package:rick_and_morty/features/character/data/remote/character_api.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl(this._api, this._db);
  final CharacterApi _api;
  final AppDatabase _db;

  @override
  @override
  Stream<Either<Failure, List<CharacterEntity>>> watchCharacters() {
    return _db.characterDao.watchCharacters().asyncMap((rows) async {
      try {
        if (rows.isEmpty) {
          final fetchResult = await _fetchAndCacheCharacters();

          return fetchResult.fold((failure) => Left(failure), (_) => Right([]));
        }

        final originIds = rows.map((r) => r.fkOrigin).toSet().toList();
        final locationIds = rows.map((r) => r.fkLocation).toSet().toList();
        final places = await _db.placeDao.getPlacesByIds([
          ...originIds,
          ...locationIds,
        ]);
        final placeMap = {for (var p in places) p.id: p};

        final List<CharacterEntity> entities = [];
        for (final row in rows) {
          var origin = placeMap[row.fkOrigin];
          origin ??= await _db.placeDao.getPlaceById(row.fkOrigin);
          var location = placeMap[row.fkLocation];
          location ??= await _db.placeDao.getPlaceById(row.fkLocation);

          entities.add(await CharacterEntity.fromTable(row, origin, location));
        }

        return Right(entities);
      } catch (e) {
        return Left(UnknownFailure(e.toString()));
      }
    });
  }

  Future<Either<Failure, void>> _fetchAndCacheCharacters() async {
    try {
      final isInternetConnection =
          await InternetConnectionChecker.instance.hasConnection;
      if (!isInternetConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final result = await _api.getAllCharacters();

      return await result.fold((failure) => Left(failure), (data) async {
        await _db.transaction(() async {
          for (final chr in data) {
            await _db.characterDao.insertCharacter(chr);
          }
        });
        return const Right(null);
      });
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<CharacterEntity>>> watchFavoriteCharacters() {
    return _db.characterDao.watchFavoriteCharacters().asyncMap((rows) async {
      try {
        final originIds = rows.map((r) => r.fkOrigin).toSet().toList();
        final locationIds = rows.map((r) => r.fkLocation).toSet().toList();
        final places = await _db.placeDao.getPlacesByIds([
          ...originIds,
          ...locationIds,
        ]);
        final placeMap = {for (var p in places) p.id: p};

        final List<CharacterEntity> entities = [];
        for (final row in rows) {
          var origin = placeMap[row.fkOrigin];
          origin ??= await _db.placeDao.getPlaceById(row.fkOrigin);
          var location = placeMap[row.fkLocation];
          location ??= await _db.placeDao.getPlaceById(row.fkLocation);
          entities.add(await CharacterEntity.fromTable(row, origin, location));
        }

        return Right(entities);
      } catch (e) {
        return Left(DatabaseFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> toggleFavoriteStatus(
    int characterId,
    bool isFavorite,
  ) async {
    try {
      await _db.characterDao.updateCharacterFavorite(characterId, isFavorite);
      return const Right(null);
    } catch (e) {
      if (e is StateError) {
        return Left(DatabaseFailure('Персонаж не найден в базе данных'));
      }
      return Left(
        DatabaseFailure('Ошибка при обновлении избранного: ${e.toString()}'),
      );
    }
  }
}
