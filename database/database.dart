import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DatabaseHelper {
  static Future<Database> initializeDB() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return openDatabase(
      path,
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT, lastName TEXT, username TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  static Future<int> insertUser(User user) async {
    final Database db = await initializeDB();
    return await db.insert('users', user.toMap());
  }

  static Future<User?> getUser(String username) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: "username = ?",
      whereArgs: [username],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  static Future<int> updateUser(User user) async {
    final db = await initializeDB();
    return await db.update(
      'users',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteUser(int id) async {
    final db = await initializeDB();
    return await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}