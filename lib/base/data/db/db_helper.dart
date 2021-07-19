import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app_dao.dart';

part 'db_helper.g.dart'; // the generated code will be there

// fake entity for testing purpose, delete in real project
@Database(
  version: 1,
  entities: [
    InitEntity,
  ],
)
abstract class DatabaseHelper extends FloorDatabase {
  AppDao get appDao;
}

// fake entity for testing purpose, delete in real project
@entity
class InitEntity {
  @PrimaryKey(autoGenerate: true)
  int? y;

  String x;

  InitEntity(this.x);
}
