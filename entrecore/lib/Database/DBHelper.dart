import 'package:entrecor/Model/Note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DBHelper {
  //Definal
  final String TABLE_NAME = "Note";

  static Database db_instandce;

  Future<Database> get db async {
    if (db_instandce == null) db_instandce = await initDB();
    return db_instandce;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Entrecore.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFnc);
    return db;
  }

  void onCreateFnc(Database db, int version) async {
    //Create Table
    await db.execute(
        'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, topic TEXT, date TEXT);');
  }

  //CRUD Functions

  //Get Notes
  Future<List<Note>> getNotes() async {
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $TABLE_NAME');
    List<Note> notes = new List();

    for (int i = 0; i < list.length; i++) {
      Note note = new Note();
      note.id = list[i]['id'];
      note.topic = list[i]['topic'];
      note.date = list[i]['date'];

      notes.add(note);
    }
    return notes;
  }

  //Add new Notes
  void addNewNote(Note note) async {
    var db_connection = await db;
    String query =
        'INSERT INTO $TABLE_NAME(topic,date) VALUES(\'${note.topic}\',\'${note.date}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  //Update Note
  void updateNote(Note note) async {
    var db_connection = await db;
    String query = 'UPDATE $TABLE_NAME SET topic=\'${note.topic}\', date=\'${note.date}\' WHERE id=${note.id}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  //Delete Note
  void deleteNote(Note note) async {
    var db_connection = await db;
    String query = 'DELETE FROM $TABLE_NAME WHERE id=${note.id}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
  
}
