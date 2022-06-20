import 'package:endurance/database/model/preset.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('endurance.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE ${tablePreset} (
        ${PresetFields.id} ${idType},
        ${PresetFields.name} ${textType},
        ${PresetFields.createdAt} ${textType},
        ${PresetFields.modifiedAt} ${textType}
       )
    ''');
  }

  Future<Preset> create(Preset preset) async {
    final db = await instance.database;
    if (preset.id == null) {
      preset.createdAt = DateTime.now();
    }
    preset.modifiedAt = DateTime.now();
    final id = await db.insert(tablePreset, preset.toMap());
    return preset.copy(id: id);
  }

  Future<Preset> readPreset(int id) async {
    final db = await instance.database;
    final response = await db.query(tablePreset,
        columns: PresetFields.values,
        where: '${PresetFields.id} = ?',
        whereArgs: [id]);
    if (response.isNotEmpty) {
      return Preset.fromMap(response.first);
    }
    throw Exception('ID ${id} not found');
  }

  Future<List<Preset>> readAllPreset() async {
    print('*****');
    final db = await instance.database;
    const orderBy = '${PresetFields.name} ASC';
    final response = await db.query(tablePreset, orderBy: orderBy);
    return response.map((map) => Preset.fromMap(map)).toList();
  }

  Future<int> update(Preset preset) async {
    final db = await instance.database;
    preset.modifiedAt = DateTime.now();
    return db.update(tablePreset, preset.toMap(),
        where: '${PresetFields.id} = ?', whereArgs: [preset.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db
        .delete(tablePreset, where: '${PresetFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
