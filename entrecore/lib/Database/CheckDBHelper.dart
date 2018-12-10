import 'package:entrecor/Model/check.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DBHelper {
  //Definal
  final String TABLE_NAME = "Checkbox";

  static Database db_instandce;

  Future<Database> get db async {
    if (db_instandce == null) db_instandce = await initDB();
    return db_instandce;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Checkbox.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFnc);
    return db;
  }

  void onCreateFnc(Database db, int version) async {
    //Create Table
    await db.execute(
        'CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT, topic TEXT, date TEXT);');
  }

  //CRUD Functions

  //Get checks
  Future<List<Check>> getchecks() async {
    var db_connection = await db;
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $TABLE_NAME');
    List<Check> checks = new List();

    for (int i = 0; i < list.length; i++) {
      Check check = new Check();
      check.name = list[i]['name'];

      checks.add(check);
    }
    return checks;
  }

  //Add new checks
  void addNewCheck(Check check) async {
    var db_connection = await db;
    String query =
        'INSERT INTO $TABLE_NAME(name) VALUES(\'${check.name}\')';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  //Update Check
  void updateCheck(Check check) async {
    var db_connection = await db;
    String query = 'UPDATE $TABLE_NAME SET name=\'${check.name}\'}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  //Delete Check
  void deleteCheck(Check check) async {
    var db_connection = await db;
    String query = 'DELETE FROM $TABLE_NAME WHERE id=${check.name}';
    await db_connection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }
  
}
