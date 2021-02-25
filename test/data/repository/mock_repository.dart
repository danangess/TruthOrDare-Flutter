import 'package:truth_or_dare/data/model/model.dart';
import 'package:truth_or_dare/data/repository/repository.dart';

abstract class MockRepository<TItem extends Model>
    implements BaseRepository<TItem> {
  static Map<int, Model> database = Map();
  FromMap<TItem> fromMap;

  @override
  void dispose() {
    database.clear();
  }

  @override
  Future<TItem> fetch(Object id) async {
    return database[id];
  }

  @override
  Future<List<TItem>> fetchMultiple(Iterable<Object> ids) async {
    var result = database.values.where((element) => ids.contains(element.id));
    return result.map((e) => this.fromMap(e.toMap()));
  }

  @override
  Future<List<TItem>> fetchAll({int skip = 0, int take = 10}) async {
    return database.values
        .skip(skip)
        .take(take)
        .map((e) => this.fromMap(e.toMap()));
  }

  @override
  Future<void> insert(TItem item) async {
    database[item.id] = item;
  }

  @override
  Future<void> insertMultiple(List<TItem> items) async {
    items.forEach((element) {
      this.insert(element);
    });
  }

  @override
  Future<void> remove(Object id) async {
    database.remove(id);
  }

  @override
  Future<void> removeMultiple(List<Object> ids) async {
    database.removeWhere((key, value) => ids.contains(key));
  }

  @override
  Future<void> update(TItem item) async {
    database[item.id] = item;
  }

  @override
  Future<void> updateMultiple(List<TItem> items) async {
    items.forEach((element) {
      this.update(element);
    });
  }

  @override
  Future<void> clear() async {
    database.clear();
  }
}

// class Repository<TItem extends Model>{

//   BaseRepository<TItem> mock() {
//     var repo = new MockRepository<TItem>();
//     when(repo.insert(any)).thenAnswer((realInvocation) async {
//       database[] = any;
//     });
//     return repo;
//   }
// }
