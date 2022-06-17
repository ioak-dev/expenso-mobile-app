import 'package:endurance/data/activity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'endurance.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE activity (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              name TEXT NOT NULL,
              seconds INTEGER NOT NULL, 
              order INTEGER NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }
}