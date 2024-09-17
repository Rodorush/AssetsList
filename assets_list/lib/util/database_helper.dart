import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/asset.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  String table = "assets";
  String id = "id";
  String ticker = "ticker";
  String name = "name";
  String price = "price";
  String lastPriceDate = "lastPriceDate";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'assets.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $ticker TEXT,
        $name TEXT,
        $price REAL,
        $lastPriceDate TEXT
      )
    ''');
  }

  Future<List<Asset>> getAssets() async {
    final db = await database;
    final List<Map<String, dynamic>> assets = await db.query('assets');
    return assets.map((asset) => Asset.fromMap(asset)).toList();
  }

  Future<void> insertAsset(Asset asset) async {
    final db = await database;
    await db.insert(
      'assets',
      asset.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAsset(Asset asset) async {
    final db = await database;
    await db.update(
      'assets',
      asset.toMap(),
      where: "id = ?",
      whereArgs: [asset.id],
    );
  }

  Future<void> deleteAsset(int id) async {
    final db = await database;
    await db.delete(
      'assets',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}