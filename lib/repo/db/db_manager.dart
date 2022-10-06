import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const String DB_NAME = "ZEMA.db";
  DatabaseManager._privateConstructor();

  static DatabaseManager getInstance() => DatabaseManager._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var dbPath = await getDatabasesPath();
    var path = ("${dbPath}/${DB_NAME}");
    var result = await openDatabase(path, version: 1, onCreate: createTable);
    return result;
  }

  Future<void> createTable(Database db, int version) async {
    try {
      var result = await db.execute('''
          CREATE TABLE Download (
            id INTEGER PRIMARY KEY,
            taskId TEXT ,
            fileId TEXT ,
            name TEXT ,
            url TEXT NOT NULL,
            location TEXT ,
            status TEXT ,
            type TEXT ,
            typeId TEXT ,
            image TEXT,
            date INTEGER            
          )
          ''');
      print("db created successfully");
    } catch (ex) {
      print("db create exception ${ex.toString()}");
    }
  }

  //list of database names
  static const DB_TABLE_DOWNLOAD = "Download";
}
