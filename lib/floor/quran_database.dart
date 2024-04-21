
import 'package:efficientmuraja3a/floor/quarter_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'data/db_quarter.dart';

part 'quran_database.g.dart';

@Database(version: 1, entities: [DBQuarter])
abstract class QuranDatabase extends FloorDatabase {
  QuarterDAO get quarterDAO;
}