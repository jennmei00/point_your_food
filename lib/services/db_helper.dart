import 'package:community_material_icon/community_material_icon.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class DBHelper {
  static sql.Database? _database;
  static int versionNumber = 3;

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

    return data.isNotEmpty ? data[0] : {};
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

  //DELETE
  static Future<void> delete(String table, {String? where}) async {
    final db = await DBHelper.openDatabase();
    sql.Batch batch = db.batch();
    batch.delete(table, where: where);
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
        'PointSafeDate TEXT, Age INTEGER, Gender INTEGER, Goal INTEGER, Height REAL, Movement INTEGER,'
        'FOREIGN KEY(StartweightID) REFERENCES Weight(ID), FOREIGN KEY(TargetweightID) REFERENCES Weight(ID), '
        'FOREIGN KEY(CurrentweightID) REFERENCES Weight(ID))');

    await db.execute(
        'CREATE TABLE Weigh(ID TEXT PRIMARY KEY, Date TEXT, Weight REAL)');

    await db.execute(
        'CREATE TABLE Diary(ID TEXT PRIMARY KEY, Date TEXT, Dailyrestpoints REAL)');

    await db.execute(
        'CREATE TABLE Food(ID TEXT PRIMARY KEY, Title TEXT, Points REAL)');

    await db.execute(
        'CREATE TABLE Activity(ID TEXT PRIMARY KEY, Title TEXT, Points REAL, IconCodePoint INTEGER, '
        'IconFontFamily TEXT, IconPackage TEXT, IconMathTextDirection BOOLEAN)');

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
        'CREATE TABLE Fitpoint(ID TEXT PRIMARY KEY, DiaryID TEXT, ActivityID TEXT, Duration TEXT, Points REAL,'
        'FOREIGN KEY(DiaryID) REFERENCES Diary(ID), FOREIGN KEY(ActivityID) REFERENCES Activity(ID))');

    //INSERT
    await db.execute(
        "INSERT INTO Weight VALUES('0Startweight0', 'Startgewicht', '${DateTime.now()}', NULL)");
    await db.execute(
        "INSERT INTO Weight VALUES('0Targetweight0', 'Zielgewicht', '${DateTime.now()}', NULL)");
    await db.execute(
        "INSERT INTO Weight VALUES('0Currentweight0', 'Aktuelles Gewicht', '${DateTime.now()}', NULL)");

    await db.execute(
        "INSERT INTO Profiledata VALUES('${const Uuid().v1()}', NULL, NULL, 0, 0, '0Startweight0', '0Targetweight0', "
        "'0Currentweight0', '${DateTime.now()}', NULL, 1, 0, NULL, 0)");

    await db.execute(
        "INSERT INTO Activity VALUES('0Bike0','Fahrrad', 3, ${CommunityMaterialIcons.bike.codePoint}, "
        "'${CommunityMaterialIcons.bike.fontFamily}', '${CommunityMaterialIcons.bike.fontPackage}', "
        "${CommunityMaterialIcons.bike.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0Hike0','Wandern', 3, ${CommunityMaterialIcons.hiking.codePoint}, "
        "'${CommunityMaterialIcons.hiking.fontFamily}', '${CommunityMaterialIcons.hiking.fontPackage}', "
        "${CommunityMaterialIcons.hiking.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0WeightTraining0','Krafttraining', 5, ${CommunityMaterialIcons.weight_lifter.codePoint}, "
        "'${CommunityMaterialIcons.weight_lifter.fontFamily}', '${CommunityMaterialIcons.weight_lifter.fontPackage}', "
        "${CommunityMaterialIcons.weight_lifter.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0Swim0','Schwimmen', 4, ${CommunityMaterialIcons.swim.codePoint}, "
        "'${CommunityMaterialIcons.swim.fontFamily}', '${CommunityMaterialIcons.swim.fontPackage}', "
        "${CommunityMaterialIcons.swim.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0Yoga0','Yoga', 2, ${CommunityMaterialIcons.yoga.codePoint}, "
        "'${CommunityMaterialIcons.yoga.fontFamily}', '${CommunityMaterialIcons.yoga.fontPackage}', "
        "${CommunityMaterialIcons.yoga.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0Dance0','Tanzen', 2, ${CommunityMaterialIcons.dance_ballroom.codePoint}, "
        "'${CommunityMaterialIcons.dance_ballroom.fontFamily}', '${CommunityMaterialIcons.dance_ballroom.fontPackage}', "
        "${CommunityMaterialIcons.dance_ballroom.matchTextDirection == true ? 1 : 0})");
    await db.execute(
        "INSERT INTO Activity VALUES('0Others0','Sonstiges', 2, ${CommunityMaterialIcons.walk.codePoint}, "
        "'${CommunityMaterialIcons.walk.fontFamily}', '${CommunityMaterialIcons.walk.fontPackage}', "
        "${CommunityMaterialIcons.walk.matchTextDirection == true ? 1 : 0})");

    await _upgradeTables(db, 1, versionNumber);
  }

  // Upgrade Tables
  static Future<void> _upgradeTables(
      sql.Database db, int oldVersion, int newVersion) async {
    // ab Version 2
    if (oldVersion < 2) {
      try {
        print('Upgrade table');
        await db.execute('ALTER TABLE Diary ADD ActualPointSafe REAL');
        // await db.execute('ALTER TABLE StandingOrder ADD FOREIGN KEY(AccountToID) REFERENCES Account(ID)');
      } catch (ex) {
        // FileHelper()
        //     .writeAppLog(AppLog(ex.toString(), 'Upgrade Tables Version 2'));
        print('DBHelper $ex');
      }
    }
  }
}
