import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/asset.dart';

class DatabaseHelper {
  //Atributo de classe privado que armazena a referência do objeto singleton
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  //Construtor que retorna a referência da instânca privada do banco
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal(); //Construtor nomeado e privado

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

  // CRUD operations
  Future<List<Asset>> getAssets() async {
    final db = await database;
    final assets = await db.query('assets');
    return List.generate(assets.length, (i) {
      return Asset(
        id: assets[i]['id'] as int,
        ticker: assets[i]['ticker'] as String,
        name: assets[i]['name'] as String,
        price: assets[i]['price'] as double,
        lastPriceDate: assets[i]['lastPriceDate'] as DateTime,
      );
    });
  }

  Future<void> insertAsset(Asset asset) async {
    final db = await database;
    await db.insert('assets', asset.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
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