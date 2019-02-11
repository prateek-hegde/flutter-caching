import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_test/dataModel.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "posts.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE posts (id INTEGER PRIMARY KEY, title TEXT, body TEXT)');
    });
  }

  Future<List<Posts>> getAllPosts() async {
    final db = await database;
    var res = await db.query("Posts");
    List<Posts> list =
        res.isNotEmpty ? res.map((c) => Posts.fromMap(c)).toList() : [];
    return list;
  }

  void deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from posts");
}

  newPosts(Posts newPosts) async {
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM posts");
    int id = table.first["id"];

    var raw = await db.rawInsert(
        "INSERT Into posts (id, title, body)"
        " VALUES (?,?,?)",
        [id, newPosts.title, newPosts.body]);
    return raw;
  }
}
