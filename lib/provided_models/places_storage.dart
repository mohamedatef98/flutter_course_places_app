import 'dart:io';

import 'package:project_5/models/location.dart';
import 'package:project_5/models/place.dart';
import 'package:sqflite/sqflite.dart';

class PlacesStorage {
  static const _tableName = 'great_places';
  static const _dbName = 'great_places';
  Database? _db;

  Future<void> storePlace(Place place) async {
    await _ensureDbReady();
    await _db!.insert(
      _tableName,
      {
        'id': place.id,
        'title': place.title,
        'image': place.image.path,
        'lat': place.location.lat,
        'long': place.location.long,
        'address': place.location.address
      },
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    await _ensureDbDisposed();
  }

  Future<List<Place>> getPlaces() async {
    await _ensureDbReady();
    final dbRows = await _db!.query(_tableName);
    await _ensureDbDisposed();
    return dbRows.map((dbRow) {
      final location = Location(
        lat: dbRow['lat']! as double,
        long: dbRow['long']! as double,
        address: dbRow['address']! as String,
      );

      return Place(
        id: dbRow['id']! as String,
        title: dbRow['title']! as String,
        location: location,
        image: File(dbRow['image']! as String)
      );
    }).toList();
  }

  Future<void> _ensureDbReady() async {
    if(_db == null) {
      final dbPath = await getDatabasesPath();
      _db = await openDatabase(
        '$dbPath/$_dbName',
        onCreate: (db, version) async {
          await db.execute('''
              CREATE TABLE $_tableName (
                id      TEXT PRIMARY_KEY,
                title   TEXT NOT_NULL,
                image   TEXT NOT_NULL,
                lat     REAL NOT_NULL,
                long    REAL NOT_NULL,
                address TEXT NOT_NULL
              )
          ''');
        },
        version: 1
      );
      // await deleteDatabase('$dbPath/$_dbName');
    }
  }

  Future<void> _ensureDbDisposed() async {
    assert(_db != null);
    await _db!.close();
    _db = null;
  }
}
