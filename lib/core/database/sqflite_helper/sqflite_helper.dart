import 'package:sqflite/sqflite.dart';
import 'package:toddo_app/features/auth/data/models/tasks_model.dart';

class sqfliteHelper {
  late Database db;

  Future<Database> initdb() async {
    // => created the database
    return await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (
        Database db,
        int v,
      ) async {
        // => created the tables
        return await db.execute('''
        CREATE TABLE Tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT ,
          title TEXT,
          note TEXT,
          date TEXT,
          startTime TEXT,
          endTime TEXT,
          color INTEGER,
          isCompleted INTEGER )
        ''').then(
          (value) => print('Tasks created sucessfuly'),
        );
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value).catchError((e) {
      print('Error initializing database: $e');
    });
  }

  //! getFromDb

  Future<List<Map<String, dynamic>>> getFromDb() async {
    return await db.rawQuery('SELECT * FROM Tasks');
  }

  //! insertIntoDb

  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert('''
      INSERT INTO Tasks( 
      title ,note ,date ,startTime ,endTime ,color ,isCompleted )
         VALUES
         ('${model.title}','${model.note}','${model.date}','${model.startTime}',
       '${model.endTime}','${model.color}','${model.isCompleted}')''');
  }

  // Future<dynamic> insertIntoDb(TaskModel model) async {
  //   return await db.rawInsert(
  //       'INSERT INTO Tasks(title, notes, date, startTime, endTime, color, complete) VALUES("${model.title}", "${model.note}", "${model.date}", "${model.startTime}", "${model.endTime}","${model.color}", "${model.isCompleted}")');
  // }

  //!updateInDb
  Future<int> updateDb(int id) async {
    return await db.rawUpdate('''
        UPDATE Tasks 
        SET isCompleted = ?
        WHERE id = ?
    ''', [1, id]);
  }

  //!DeleteFromDb
  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete(
      '''DELETE FROM Tasks WHERE id = ?''',
      [id],
    );
  }
}
