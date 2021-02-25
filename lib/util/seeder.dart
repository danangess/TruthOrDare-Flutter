import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:truth_or_dare/data/model/model.dart';
import 'package:truth_or_dare/data/repository/repository.dart';

class Seeder<TModel extends Model> {
  final String jsonPath;
  final BaseRepository<TModel> repository;

  Seeder(this.jsonPath, this.repository);

  Future<void> seed() async {
    if (await this._dataExist()) {
      return;
    }

    String string = await rootBundle.loadString(this.jsonPath);
    final json = JsonDecoder().convert(string);
    List<TModel> models = new List();
    json.forEach((element) {
      models.add(repository.fromMap(element));
    });
    this.repository.insertMultiple(models);
  }

  Future<bool> _dataExist() async {
    var models = await this.repository.fetchAll(skip: 0, take: 1);
    return models.isNotEmpty;
  }
}