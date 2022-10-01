// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DataBaseHelper implements TodoListSQFLiteDataSource{
//   static Database? _database;
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     final Directory directory = await getApplicationDocumentsDirectory();
//     String path = '${directory}tasks.db';
//      _database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute(
//             'CREATE TABLE Task (id TEXT PRIMARY KEY, title TEXT, note TEXT,isDone BLOB)');
//       },
//     );

//     return _database;
//   }





// }
