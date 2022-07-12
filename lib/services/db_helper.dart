import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static sql.Database? _database;
  static int versionNumber = 1;

  //Open Database
  static Future<sql.Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return _database ??= await sql.openDatabase(
        path.join(dbPath, 'PointYourFood.db'),
        onCreate: _createTables,
        onUpgrade: _upgradeTables,
        version: versionNumber);
  }

  //Delete Database
  static Future<void> deleteDatabse() async {
    final dbPath = await sql.getDatabasesPath();
    await sql.deleteDatabase('$dbPath/PointYourFood.db');
    _database = null;
  }

  //Functions
  //GETDATA
  static Future<List<Map<String, dynamic>>> getData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    final db = await DBHelper.openDatabase();
    return db.transaction((txn) async {
      return await txn.query(table,
          columns: columns, where: where, orderBy: orderBy);
    });
  }

  static Future<Map<String, dynamic>> getOneData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    List<Map<String, dynamic>> data =
        await getData(table, columns: columns, where: where, orderBy: orderBy);

    return data[0];
  }

  //INSERT
  static Future<void> multipleInsert(
      String table, List<Map<String, dynamic>> dataList) async {
    final db = await DBHelper.openDatabase();
    sql.Batch batch = db.batch();
    for (var data in dataList) {
      batch.insert(table, data);
    }
    await batch.commit();
  }

  static Future<void> multipleInsertOrUpdate(String table,
      List<Map<String, dynamic>> dataList, String primaryKey) async {
    final db = await DBHelper.openDatabase();
    sql.Batch batch = db.batch();
    for (var data in dataList) {
      var primaryKeyValue = data[primaryKey];
      int counted = await count(table,
          where: "WHERE $primaryKey = '${data[primaryKey]}'");
      if (counted > 0) {
        data.removeWhere((k, v) => k == primaryKey);
        batch.update(table, data, where: "$primaryKey = '$primaryKeyValue'");
      } else {
        batch.insert(table, data);
      }
    }
    await batch.commit();
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.openDatabase();
    sql.Batch batch = db.batch();
    batch.insert(table, data);
    await batch.commit();
  }

  static Future<void> update(String table, Map<String, dynamic> data,
      {String? where}) async {
    final db = await DBHelper.openDatabase();
    sql.Batch batch = db.batch();
    batch.update(table, data, where: where);
    await batch.commit();
  }

  //COUNT
  static Future<int> count(String table, {String where = ''}) async {
    final db = await DBHelper.openDatabase();
    return await db.transaction((txn) async {
      return sql.Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COUNT(*) FROM $table${where.isNotEmpty ? ' $where' : ''}'))
          as Future<int>;
    });
  }

  //////////COPY - PASTE ----- Muss noch angeschaut und evtl. angepasst werden!
  // //SUM
  // static Future<double> sum(String table, String column,
  //     {String where = ''}) async {
  //   final db = await DBHelper.openDatabase();
  //   return db.transaction((txn) async {
  //     List<Map<String, dynamic>> _result;
  //     if (where != null && where.isNotEmpty) {
  //       _result = await txn
  //           .rawQuery('SELECT SUM($column) As Result FROM $table WHERE $where');
  //     } else {
  //       _result =
  //           await txn.rawQuery('SELECT SUM($column) As Result FROM $table');
  //     }

  //     if (_result != null && _result.length > 0) {
  //       return _result[0]['Result'];
  //     }
  //     return 0;
  //   });
  // }

  // //MAX
  // static Future<int> max(String table, String column,
  //     {String where = ''}) async {
  //   final db = await DBHelper.openDatabase();
  //   return db.transaction((txn) async {
  //     List<Map<String, dynamic>> _result;
  //     if (where != null && where.isNotEmpty) {
  //       _result = await txn
  //           .rawQuery('SELECT MAX($column) As Result FROM $table WHERE $where');
  //     } else {
  //       _result =
  //           await txn.rawQuery('SELECT MAX($column) As Result FROM $table');
  //     }

  //     if (_result != null && _result.length > 0) {
  //       return _result[0]['Result'];
  //     }
  //     return 0;
  //   });
  // }

  //Create Tables
  static Future<void> _createTables(sql.Database db, int version) async {
    await db.execute(
        'CREATE TABLE Weight(ID TEXT PRIMARY KEY, Title TEXT, Date TEXT, Weight REAL)');

    await db.execute(
        'CREATE TABLE Profiledata(ID TEXT PRIAMRY KEY, Name TEXT, Email TEXT, Dailypoints REAL, Pointsafe REAL, '
        'StartweightID TEXT, TargetweightID TEXT, CurrentweightID TEXT, '
        'FOREIGN KEY(StartweightID) REFERENCES Weight(ID), FOREIGN KEY(TargetweightID) REFERENCES Weight(ID), '
        'FOREIGN KEY(CurrentweightID) REFERENCES Weight(ID))');

    await db.execute(
        'CREATE TABLE Weigh(ID TEXT PRIMARY KEY, Date TEXT, Weight REAL)');

    await db.execute(
        'CREATE TABLE Diary(ID TEXT PRIMARY KEY, Date TEXT, Dailyrestpoints REAL)');

    await db.execute(
        'CREATE TABLE Food(ID TEXT PRIMARY KEY, Title TEXT, Points REAL)');

    await db.execute(
        'CREATE TABLE Activity(ID TEXT PRIMARY KEY, Title TEXT, Points REAL)');

    await db.execute(
        'CREATE TABLE Breakfast(ID TEXT PRIMARY KEY, DiaryID TEXT, FoodID TEXT, '
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(FoodID) REFERENCES Food(ID))');

    await db.execute(
        'CREATE TABLE Lunch(ID TEXT PRIMARY KEY, DiaryID TEXT, FoodID TEXT, '
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(FoodID) REFERENCES Food(ID))');

    await db.execute(
        'CREATE TABLE Dinner(ID TEXT PRIMARY KEY, DiaryID TEXT, FoodID TEXT, '
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(FoodID) REFERENCES Food(ID))');

    await db.execute(
        'CREATE TABLE Snack(ID TEXT PRIMARY KEY, DiaryID TEXT, FoodID TEXT, '
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(FoodID) REFERENCES Food(ID))');

    await db.execute(
        'CREATE TABLE Fitpoint(ID TEXT PRIMARY KEY, DiaryID TEXT, ActivityID TEXT, '
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(ActivityID) REFERENCES Activity(ID))');
  }

  // Upgrade Tables
  static Future<void> _upgradeTables(
      sql.Database db, int oldVersion, int newVersion) async {
    // ab Version 2
    if (oldVersion < 2) {
      //   try {
      //     await db.execute('ALTER TABLE StandingOrder ADD AccountToID TEXT');
      //     await db.execute('ALTER TABLE Transfer ADD StandingOrderID TEXT');
      //     await db.execute('ALTER TABLE Transfer ADD IsStandingOrder BOOLEAN');
      //     // await db.execute('ALTER TABLE StandingOrder ADD FOREIGN KEY(AccountToID) REFERENCES Account(ID)');
      //   } catch (ex) {
      //     // FileHelper()
      //     //     .writeAppLog(AppLog(ex.toString(), 'Upgrade Tables Version 2'));

      //   print('DBHelper $ex');
      //   }
    }
  }
}
