import 'dart:io' show Directory;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/utils/api.dart';

class DataBaseProvider {
  static Database? _database;
  static String? _databasePath;

  static final _databaseName = "wallpapers.db";
  static final _databaseVersion = 1;

  static final columnId = 'pid';
  static final columnTitle = 'title';
  static final columnUrlsRegular = 'urls_regural';
  static final columnIsPhoto = 'isphoto';

  DataBaseProvider._privateConstructor();
  static final DataBaseProvider instance =
      DataBaseProvider._privateConstructor();

  // only have a single app-wide reference to the database
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $kTable (
            $columnId TEXT PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnUrlsRegular TEXT NOT NULL,
            $columnIsPhoto INTEGER NOT NULL
          )
          ''');
  }

  /* Future<List<Photo>> getAllPhotos() async {
    final List<Map<String, dynamic>> tasks = await database.query(kTable);

    return List.generate(tasks.length, (i) {
      return MovieEntity(Title: tasks[i][Title], Id: tasks[i][Id]);
    });
  } */

  /* static Future open() async {
    _databasePath = await getDatabasesPath() + _databaseName;
    _database = await openDatabase(_databasePath!, version: _databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $kTable
          ($columnId TEXT PRIMARY KEY, $columnTitle TEXT, $columnUrlsRegular TEXT, $columnIsPhoto INTEGER)
          ''');
    });
    return _database;
  } */
}
// , $columnIsPhoto INTEGER
