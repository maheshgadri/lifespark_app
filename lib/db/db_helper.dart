import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'email.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE emails(id INTEGER PRIMARY KEY, email TEXT)",
        );
      },
    );
  }

  Future<void> insertEmail(String email) async {
    final db = await database;
    await db.insert(
      'emails',
      {'email': email},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getEmail() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('emails');

    if (maps.isNotEmpty) {
      return maps.first['email'];
    }
    return null;
  }

  Future<void> deleteEmail() async {
    final db = await database;
    await db.delete('emails');
  }
}
