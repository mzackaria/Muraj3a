import 'package:efficientmuraja3a/floor/data/db_quarter.dart';
import 'package:efficientmuraja3a/floor/quran_database.dart';
import 'package:flutter/cupertino.dart';

import '../../constants.dart';
import '../../model/quarter.dart';

class SelectQuartersViewModel extends ChangeNotifier {

  List<Quarter> _quarters = [];
  List<Quarter> get quarters => _quarters;

  late QuranDatabase db;

  SelectQuartersViewModel() {
    $FloorQuranDatabase
        .databaseBuilder('quran_database.db')
        .build().then((value) async {
          db = value;
          List<DBQuarter> quarters = await db.quarterDAO.getAllQuarters();

          fillDatabaseIfEmpty(quarters);

          //adding all quarters
          _quarters.addAll(quarters.map((e) => e.toUIModdel()));
          notifyListeners();
    });
  }

  Future<void> fillDatabaseIfEmpty(List<DBQuarter> quarters) async {
    if (quarters.isNotEmpty) return;
    for (int i = 1; i <= 60; i++) {
      for (int j = 1; j <= 4; j++) {
        db.quarterDAO.insertQuarter(DBQuarter(hizb: i, quarter: j));
      }
    }
  }

  void addQuarter(int hizb, int quarter) {
    db.quarterDAO.getQuarter(hizb, quarter)
        .then((value) async {
          value[0].note1 = MAX_NOTE;
          db.quarterDAO.updateQuarter(value[0]);
          _quarters.remove(value[0].toUIModdel());
          _quarters.add(value[0].toUIModdel());
          notifyListeners();
    });
  }

  void removeQuarter(int hizb, int quarter) {
    db.quarterDAO.getQuarter(hizb, quarter)
        .then((value) async {
          value[0].resetNotes();
          db.quarterDAO.updateQuarter(value[0]);
          _quarters.remove(value[0].toUIModdel());
          _quarters.add(value[0].toUIModdel());
          notifyListeners();
    });
  }

}