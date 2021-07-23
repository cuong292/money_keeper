import 'dart:async';

import 'package:base_flutter/data/bill.dart';
import 'package:base_flutter/data/bill_by_month.dart';
import 'package:base_flutter/data/user.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app_dao.dart';

part 'db_helper.g.dart'; // the generated code will be there

// fake entity for testing purpose, delete in real project
@Database(
  version: 1,
  entities: [
    Bill,
    BillByMonth,
    User
  ],
)
abstract class DatabaseHelper extends FloorDatabase {
  AppDao get appDao;
}

// fake entity for testing purpose, delete in real project
// @entity
// class InitEntity {
//   @PrimaryKey(autoGenerate: true)
//   int? y;
//
//   String x;
//
//   InitEntity(this.x);
// }
