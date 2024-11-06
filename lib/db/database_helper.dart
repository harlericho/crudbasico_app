import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/computadora.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  static DatabaseHelper get instance => _instance;

  Future<Database> get database async {
    _database ??= await _initDB('computadoras.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE computadoras (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        procesador TEXT NOT NULL,
        discoDuro TEXT NOT NULL,
        ram TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Computadora computadora) async {
    final db = await instance.database;
    return await db.insert('computadoras', computadora.toMap());
  }

  Future<List<Computadora>> getComputadoras() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('computadoras');

    return List.generate(maps.length, (i) {
      return Computadora.fromMap(maps[i]);
    });
  }

  Future<int> update(Computadora computadora) async {
    final db = await instance.database;
    return await db.update(
      'computadoras',
      computadora.toMap(),
      where: 'id = ?',
      whereArgs: [computadora.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'computadoras',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
