import 'package:efficientmuraja3a/floor/data/db_quarter.dart';
import 'package:floor/floor.dart';

@dao
abstract class QuarterDAO {
    @insert
    Future<void> insertQuarter(DBQuarter quarter);

    @Query('SELECT * FROM DBQuarter')
    Future<List<DBQuarter>> getAllQuarters();

    @Query('SELECT * FROM DBQuarter WHERE hizb = :hizb AND quarter = :quarter')
    Future<List<DBQuarter>> getQuarter(int hizb, int quarter);

    @update
    Future<void> updateQuarter(DBQuarter quarter);
}