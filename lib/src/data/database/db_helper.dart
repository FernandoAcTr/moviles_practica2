import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  final _nameDB = "NOTASDB";
  final _versionDB = 4;
  final notasTable = 'notas';
  final userTable = 'user';
  final moviesTable = 'movies';

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _nameDB);


    return await openDatabase(
      path,
      version: _versionDB,
      onCreate: (Database db, int version) async {
        await _createNotasTable(db);
        await _createUserTable(db);
        await _createMoviesTable(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await db.execute('DROP table if exists $userTable');
        await db.execute('DROP table if exists $notasTable');
        await db.execute('DROP table if exists $moviesTable');

        await _createNotasTable(db);
        await _createUserTable(db);
        await _createMoviesTable(db);
      },
    );
  }

  _createNotasTable(Database db) async {
    final sql = "CREATE TABLE $notasTable (id INTEGER PRIMARY KEY, titulo VARCHAR(50), detalle VARCHAR(100))";
    await db.execute(sql);
  }

  _createUserTable(Database db) async {
    final sql =
        "CREATE TABLE $userTable (id INTEGER PRIMARY KEY, nombre VARCHAR(50), a_paterno VARCHAR(50), a_materno VARCHAR(50), email VARCHAR(100), telefono VARCHAR(10), about varchar(255), foto varchar(255))";
    await db.execute(sql);
  }

  _createMoviesTable(Database db) async {
    final sql =
        "CREATE TABLE $moviesTable (id INTEGER PRIMARY KEY, poster_path varchar(40), backdrop_path varchar(40), title varchar(255), vote_average real, release_date varchar(10), overview text)";
    await db.execute(sql);
  }
}
