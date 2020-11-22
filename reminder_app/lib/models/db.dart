import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:reminder_app/models/reminder.dart';



const kDatabaseName = 'reminders.db';
const kDatabaseVersion = 1;
const kSQLCreateStatement = '''
CREATE TABLE reminders (
	 id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 title TEXT NOT NULL,
	 created text NOT NULL,
	 updated TEXT NOT NULL,
	 reminderdate TEXT NOT NULL,
	 repetition TEXT NOT NULL
);
''';

const kTableReminders= 'reminders';

class DB {
  DB._();
  static final DB sharedInstance = DB._();

  Database _database;
  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, kDatabaseName);

    return await openDatabase(path, version: kDatabaseVersion,
        onCreate: (Database db, int version) async {
          await db.execute(kSQLCreateStatement);
        });
  }

  void createReminder(Reminder todo) async {
    final db = await database;
    await db.insert(kTableReminders, todo.toMapAutoID());
  }

  void updateTodo(Reminder todo) async {
    final db = await database;
    await db
        .update(kTableReminders, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteReminder(Reminder todo) async {
    final db = await database;
    await db.delete(kTableReminders, where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteAllReminders() async {
    final db = await database;
    await db.delete(kTableReminders);
  }

  Future<List<Reminder>> retrieveReminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(kTableReminders);

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return Reminder(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        reminderdate: maps[i]['reminderdate'],
        repetition: maps[i]['repetition'],

      );
    });
  }
}