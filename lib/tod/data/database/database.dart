import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const DARE_TABLE = 'dare';
const TRUTH_TABLE = 'truth';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await createDatabase();
    }
    return _database;
  }

  Future<Database> createDatabase() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, "truthOrDare.db");
    _database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return _database;
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $DARE_TABLE ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "category TEXT, "
        "text TEXT "
        ")");
    await database.execute("CREATE TABLE $TRUTH_TABLE ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "category TEXT, "
        "text TEXT "
        ")");
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    // if (newVersion == 2 && oldVersion == 1) {
    //   _upgradeV2(database);
    // }
  }
}
