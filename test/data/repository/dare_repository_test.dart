// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:truth_or_dare/data/repository/repository.dart';
import 'package:truth_or_dare/tod/data/database/database.dart';
import 'package:truth_or_dare/tod/model/model.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Dare value should be inserted', () async {
    var repo = await _getRepository();
    var dare = new Dare(id: 1, category: "cat1", text: 'description');
    await repo.insert(dare);
    var dareActual = repo.fetch(dare.id);
    expect(dareActual, dare);
  });
}

Future<BaseRepository> _getRepository() async {
  // return DareMockRepository();
  return _getSqliteRepository();
}

Future<BaseRepository> _getSqliteRepository() async {
  var repository = SqliteRepository(
      database: DatabaseProvider.dbProvider.database,
      tableName: DARE_TABLE,
      fromMap: (data) => Dare.fromMap(data));
  return repository;
}
