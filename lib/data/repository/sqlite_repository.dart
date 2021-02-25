import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:truth_or_dare/data/model/model.dart';
import 'package:truth_or_dare/data/repository/repository.dart';

class SqliteRepository<TItem extends Model> implements BaseRepository<TItem> {
  @protected
  final Future<Database> database;
  final String tableName;
  FromMap<TItem> fromMap;

  SqliteRepository(
      {@required this.database,
      @required this.tableName,
      @required this.fromMap});

  @override
  Future<TItem> fetch(Object id) async {
    final Database db = await database;
    var result = await db
        .query(this.tableName, limit: 1, where: 'id = ?', whereArgs: [id]);
    if (result.isEmpty) {
      return null;
    }
    return this.fromMap(result.single);
  }

  @override
  Future<TItem> fetchRandom() async {
    // SELECT * FROM dare WHERE id IN (SELECT id FROM dare ORDER BY RANDOM()) LIMIT 1
    // var result = await db.query(this.tableName,
    //     where: 'id IN (SELECT id FROM $tableName ORDER BY RANDOM())', limit: 1);
    final Database db = await database;
    var result = await db.query(this.tableName, orderBy: 'RANDOM()', limit: 1);
    if (result.isEmpty) {
      return null;
    }
    return fromMap(result.single);
  }

  @override
  Future<List<TItem>> fetchMultiple(Iterable<Object> ids) async {
    String idsJoin = ids.join(', ');
    final Database db = await database;
    var result = await db
        .query(this.tableName, where: 'id IN (?)', whereArgs: [idsJoin]);
    return _convertToItem(result);
  }

  @override
  Future<List<TItem>> fetchAll({int skip = 0, int take = 10}) async {
    final Database db = await database;
    var result = await db.query(this.tableName, offset: skip, limit: take);
    return _convertToItem(result);
  }

  List<TItem> _convertToItem(List<Map<String, dynamic>> maps) {
    var items = new List<TItem>();
    maps.forEach((element) {
      items.add(this.fromMap(element));
    });
    return items;
  }

  @override
  Future<void> insert(TItem item) async {
    final Database db = await database;
    await db.insert(this.tableName, item.toMap());
  }

  @override
  Future<void> insertMultiple(List<TItem> items) async {
    final Database db = await database;
    Batch batch = db.batch();
    items.forEach((item) {
      batch.insert(this.tableName, item.toMap());
    });
    batch.commit();
  }

  @override
  Future<void> remove(Object id) async {
    final Database db = await database;
    await db.delete(this.tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> removeMultiple(List<Object> ids) async {
    String idsJoin = ids.join(', ');
    final Database db = await database;
    await db.delete(this.tableName, where: 'id IN (?)', whereArgs: [idsJoin]);
  }

  @override
  Future<void> update(TItem item) async {
    final Database db = await database;
    await db.update(this.tableName, item.toMap(),
        where: 'id = ?', whereArgs: [item.id]);
  }

  @override
  Future<void> updateMultiple(List<TItem> items) async {
    final Database db = await database;
    Batch batch = db.batch();
    items.forEach((item) {
      batch.update(this.tableName, item.toMap(),
          where: 'id = ?', whereArgs: [item.id]);
    });
    batch.commit();
  }

  @override
  Future<void> clear() async {
    final Database db = await database;
    await db.execute('TRUNCATE $tableName');
  }

  @override
  void dispose() async {
    final Database db = await database;
    db.close();
  }
}
