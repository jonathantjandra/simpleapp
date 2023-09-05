import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        username TEXT,
        email TEXT,
        password TEXT
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'test3.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item 
  static Future<int> createItem(String username, String email, String password) async {
    final db = await DatabaseHelper.db();

    final data = {'username': username, 'email': email, 'password': password};
    final id = await db.insert('users', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items 
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('users', orderBy: "id");
  }

  // Get a single item by id
  //We dont use this method, it is for you if you want it.
    static Future<List<Map<String, dynamic>>> getItem(String username) async {
    final db = await DatabaseHelper.db();
    return db.query('users', where: "username = ?", whereArgs: [username], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String username, String email, String password) async {
    final db = await DatabaseHelper.db();

    final data = {
      'email': email,
      'password': password
    };

    final result =
        await db.update('users', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}