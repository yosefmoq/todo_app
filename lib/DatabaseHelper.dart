import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/Task.dart';

class DataHelper {
  static final int completed = 1;
  static final int isNotComplete = 2;

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'tasks_table';

  static final columnId = '_id';
  static final columnTitle = 'title';
  static final columnStatus = 'status';

  DataHelper._privateConstructor();
  static final DataHelper instance = DataHelper._privateConstructor();


  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnStatus INTEGER NOT NULL
          )
          ''');
  }


}
