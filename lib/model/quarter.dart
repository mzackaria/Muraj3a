import '../exceptions/wrong_hizb_number_exceptions.dart';
import '../exceptions/wrong_quarter_number_exception.dart';

class Quarter {

  static const int MAX_NOTE = 20;

  int hizb = 1;
  int quarter = 1;
  int id = 0;

  Quarter({required this.hizb, required this.quarter}) {
    if (hizb >= 1 && hizb <= 60) throw WrongHizbNumberException;
    if (quarter >= 0 && quarter <= 4) throw WrongQuarterNumberException;
    id = quarter * hizb;
  }

}