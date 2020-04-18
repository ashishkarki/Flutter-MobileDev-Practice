import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../constants.dart';

class DBHelper {
  static Future<sql.Database> database(String tableName) async {
    final dbPath =
        await sql.getDatabasesPath(); // where will the new DB be stored

    // connect to this DB: create new DB if no DB exisits
    return sql.openDatabase(
      path.join(dbPath, PLACES_DB_NAME_STRING),
      onCreate: (createdDB, dbVersion) {
        return createdDB.execute(
            'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(
      String tableName, Map<String, dynamic> data) async {
    final sql.Database sqlDb = await DBHelper.database(tableName);

    sqlDb.insert(
      tableName,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String tableName) async {
    final sql.Database sqlDb = await DBHelper.database(tableName);

    return sqlDb.query(tableName);
  }
}
