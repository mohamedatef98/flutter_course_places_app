import 'dart:io';

import 'package:flutter/cupertino.dart';
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
      'image': place.image.path
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
      return Place(
        id: dbRow['id']! as String,
        title: dbRow['title']! as String,
        location: null,
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
                id TEXT PRIMARY_KEY,
                title TEXT NOT_NULL,
                image TEXT NOT_NULL
              )
          ''');
        },
        version: 1
      );
    }
  }

  Future<void> _ensureDbDisposed() async {
    assert(_db != null);
    await _db!.close();
    _db = null;
  }
}
