import 'package:floor/floor.dart';

import '../../model/quarter.dart';

@entity
class DBQuarter {

    @PrimaryKey(autoGenerate: true)
    final int? id;
    final int hizb;
    final int quarter;
    int note1;
    int note2;
    int note3;
    int note4;
    int note5;
    int note6;
    int note7;
    int note8;
    int note9;
    int note10;

    DBQuarter({this.id,
        required this.hizb,
        required this.quarter,
        this.note1 = -1,
        this.note2 = -1,
        this.note3 = -1,
        this.note4 = -1,
        this.note5 = -1,
        this.note6 = -1,
        this.note7 = -1,
        this.note8 = -1,
        this.note9 = -1,
        this.note10 = -1
    });

    DBQuarter.fromMap(Map<String, dynamic> res)
        :   id = res["id"],
            hizb = res["hizb"],
            quarter = res["quarter"],
            note1 = res["note1"],
            note2 = res["note2"],
            note3 = res["note3"],
            note4 = res["note4"],
            note5 = res["note5"],
            note6 = res["note6"],
            note7 = res["note7"],
            note8 = res["note8"],
            note9 = res["note9"],
            note10 = res["note10"]
    ;

    Map<String, Object?> toMap() {
        return {
            'id':id,
            'hizb':hizb,
            'quarter':quarter,
            'note1':note1,
            'note2':note2,
            'note3':note3,
            'note4':note4,
            'note5':note5,
            'note6':note6,
            'note7':note7,
            'note8':note8,
            'note9':note9,
            'note10':note10
        };
    }

    Quarter toUIModdel() {
        return Quarter(hizb: hizb, quarter: quarter, isSelected: note1 >= 0);
    }

  void resetNotes() {
        note1 = -1;
        note2 = -1;
        note3 = -1;
        note4 = -1;
        note5 = -1;
        note6 = -1;
        note7 = -1;
        note8 = -1;
        note9 = -1;
        note10 = -1;
  }

}