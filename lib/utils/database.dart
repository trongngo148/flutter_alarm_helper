import 'package:analog_clock/models/data_clock.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = new DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "clock_helper.db"),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE dataclock(
            id INT PRIMARY KEY,timeFallInSleep INT, timeSleepHour INT, timeSleepMinute INT, firstInput INT
          )
          ''');
    }, version: 1);
  }

  newData(DataClock newData) async {
    final db = await database;
    var res = await db.rawInsert('''
      INSERT INTO dataclock(
       id, timeFallInSleep, timeSleepHour, timeSleepMinute, firstInput
      ) VALUES (?,?,?,?,?)
    ''', [
      newData.id,
      newData.timeFallInSleep,
      newData.timeSleepHour,
      newData.timeSleepMinute,
      newData.firstInput,
    ]);
    return res;
  }

  Future<List<DataClock>> getData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("dataclock");
    return List.generate(maps.length, (i) {
      return DataClock(
        id: maps[i]['id'],
        timeFallInSleep: maps[i]['timeFallInSleep'],
        timeSleepHour: maps[i]['timeSleepHour'],
        timeSleepMinute: maps[i]['timeSleepMinute'],
        firstInput: maps[i]['firstInput'],
      );
    });
  }

  Future<void> updateData(DataClock dataClock) async {
    final db = await database;
    await db.update(
      "dataclock",
      dataClock.toMap(),
      where: "id = ?",
      whereArgs: [dataClock.id],
    );
    print("update done");
  }
}
