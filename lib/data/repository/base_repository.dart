import 'dart:async';
import 'dart:core';

import 'package:truth_or_dare/data/model/model.dart';

typedef FromMap<T extends Model> = T Function(Map<String, dynamic> data);

abstract class BaseRepository<TItem extends Model> {
  FromMap<TItem> fromMap;

  Future<TItem> fetch(Object id);
  Future<TItem> fetchRandom();

  Future<List<TItem>> fetchMultiple(Iterable<Object> ids);
  Future<List<TItem>> fetchAll({int skip = 0, int take = 10});

  Future<void> insert(TItem item);
  Future<void> insertMultiple(List<TItem> items);

  Future<void> update(TItem item);
  Future<void> updateMultiple(List<TItem> items);

  Future<void> remove(Object id);
  Future<void> removeMultiple(List<Object> ids);

  Future<void> clear();

  void dispose() {}
}
