import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class User {
  final String username;
  final String password;
  final String email;
  final String phone;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
  });
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(path,
        version: 2, onCreate: _createTable, onUpgrade: _onUpgrade);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Perform any migration or table alteration here if needed
      // In this case, you're already creating the "email" column, so no migration is required
      await db.execute('ALTER TABLE users ADD COLUMN email TEXT;');
    }
  }

  Future<void> _createTable(Database db, int version) async {
    // Drop the existing table if it exists
    await db.execute('DROP TABLE IF EXISTS users');

    // Create the table with the updated schema
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY,
      username TEXT,
      email TEXT,
      phone TEXT,
      password TEXT
    )
  ''');
  }

  Future<User?> getUserr(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      return User(
        username: users.first['username'] ?? '',
        email: users.first['email'] ?? '',
        phone: users.first['phone'] ?? '',
        password: users.first['password'] ?? '',
      );
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      return users.first;
    } else {
      return null;
    }
  }

  Future<void> insertUser(User user) async {
    Database db = await database;
    await db.insert(
      'users',
      {
        'username': user.username,
        'email': user.email,
        'phone': user.phone,
        'password': user.password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  Future<void> updateUser(int id, String username, String password,
      String email, String phone) async {
    Database db = await database;
    await db.update(
      'users',
      {
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
      },
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUser(int userId) async {
    Database db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
