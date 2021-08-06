import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Database? db;

class DataBaseHelper {
  static const appointmentTable = 'appointment';

  static const id = 'id';
  static const name = 'name';
  static const email = 'email';
  static const phone = 'phone';
  static const password = 'password';
  static const occupation = 'occupation';

  Future<void> createTable(Database db) async {
    final tbl = '''CREATE TABLE $appointmentTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT,
      $email TEXT,
      $phone TEXT,
      $password TEXT,
      $occupation TEXT
    )''';

    await db.execute(tbl);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('appointment_app.db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTable(db);
  }
}
