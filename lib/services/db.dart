import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminders_app/model/reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';
import 'package:path/path.dart';

class DB {
  static Database _db;

  Future<Database> get database async {
    if (_db == null) _db = await initDB();

    return _db;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "reminders.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute("CREATE TABLE reminder ("
            "id INTEGER PRIMARY KEY,"
            "content TEXT,"
            "time DATETIME,"
            "repeat TEXT,"
            "color INTEGER"
            ")");
      },
    );
  }

  Future<List<Reminder>> getData(String table) async {
    final db = await database;

    final query = await db.query(table, orderBy: "id");
    final List<Reminder> list = query.map((e) => Reminder.fromMap(e)).toList();
    return list;
  }

  Future<void> insert(Reminder reminder, String table) async {
    final db = await database;
    await db.insert(table, reminder.toMap());
  }

  Future<void> delete(Reminder reminder, String table) async {
    final db = await database;
    await db.delete(table, where: "id = ?", whereArgs: [reminder.id]);
  }
}

class DBHelper with ChangeNotifier {
  List<Reminder> _reminders = [];
  final DB db;
  get reminders => _reminders.reversed.toList();

  DBHelper({this.db});

  Future<void> getReminders() async {
    if (db != null) {
      final data = await db.getData("reminder");
      _reminders.addAll(data);
      print(_reminders.length);
      notifyListeners();
    }
  }

  void insert(Reminder reminder) {
    if (db != null) {
      _reminders.add(reminder);
      db.insert(reminder, "reminder");
      notifyListeners();
    }
  }

  void delete(Reminder reminder) {
    if(db != null) {
      _reminders.remove(reminder);
      db.delete(reminder, "reminder");
      notifyListeners();
    }
  }
}
