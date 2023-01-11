import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "cart.db";
  static final _databaseVersion = 2;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY ,
        foodId INTEGER,
        name TEXT,
        price TEXT,
        image TEXT,
        quantity INTEGER,
        total INTEGER,
        options TEXT
        )
      ''');
  }

  Future<int> addCart(Map<String, dynamic> row) async {
    Database db = await instance.database;
    row['id'] = await db
        .query('cart')
        .then((value) => value == null ? 0 : (value.length as int) + 1);
    var id = row['id'];
    var cart = await db.query('cart');
    for (var item in cart) {
      if (item['foodId'] == row['foodId'] &&
          item['options'] == row['options']) {
        var q = (item['quantity'] as int) + (row['quantity'] as int);
        var t = (item['total'] as int) + (row['total'] as int);
        print(q);
        return await db.update('cart', {'quantity': q, 'total': t},
            where: 'id = ${item['id']}');
      }
    }
    return await db.insert('cart', row);
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    Database db = await instance.database;
    return await db.query('cart');
  }

  Future<int> deleteCart(int id) async {
    Database db = await instance.database;
    return await db.delete('cart', where: 'id = $id');
  }

// Future<List<Map<String,dynamic>>> AutoIncrement() async {
//     Database db = await instance.database;

//   }

  Future claerCart() async {
    Database db = await instance.database;
    return await db.delete('cart');
  }

  Future getTotal() async {
    Database db = await instance.database;
    var result = await db.query('cart').then((value) =>
        value.map((e) => e['total']).reduce((a, b) => (a as int) + (b as int)));
    return result;
  }
}
