import 'package:sqflite/sqflite.dart';

import 'fridj.dart';

class FridjRepository {

  Database db;
  String tableName = 'fridj';

  FridjRepository({required this.db});

  Future<int> insertFridj(Fridj fridj) =>
      db.insert(tableName,
        fridj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
}