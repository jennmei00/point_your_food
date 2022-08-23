import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/models/foods.dart';
import 'package:punkte_zaehler/models/profiledata.dart';
import 'package:punkte_zaehler/models/weigh.dart';
import 'package:punkte_zaehler/models/weight.dart';
import 'package:punkte_zaehler/screens/navigation.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late Future<bool> dataLoaded;

  Future<bool> loadAllData() async {
    // DBHelper.deleteDatabse();
    // DBHelper.insert(
    //     'Weight',
    //     Weight(
    //             id: 'Startweight',
    //             date: DateTime(2022, 06, 16),
    //             title: 'Startgewicht',
    //             weight: 70)
    //         .toMap());
    // DBHelper.insert(
    //     'Weight',
    //     Weight(
    //             id: 'Targetweight',
    //             date: DateTime(2022, 08, 18),
    //             title: 'Zielgewicht',
    //             weight: 60)
    //         .toMap());

    // DBHelper.insert(
    //     'Weight',
    //     Weight(
    //             id: 'Currentweight',
    //             date: DateTime(2022, 07, 01),
    //             title: 'Aktuelles Gewicht',
    //             weight: 65)
    //         .toMap());

    // DBHelper.insert(
    //     'Profiledata',
    //     ProfileData(
    //             id: Uuid().v1(),
    //             name: 'Jenny',
    //             email: 'jennmei00@yahoo.de',
    //             dailyPoints: 22,
    //             pointSafe: 0,
    //             startWeight: Weight(
    //                 id: 'Startweight',
    //                 date: DateTime(2022, 06, 16),
    //                 title: 'Startgewicht',
    //                 weight: 70),
    //             targetWeight: Weight(
    //                 id: 'Targetweight',
    //                 date: DateTime(2022, 08, 18),
    //                 title: 'Zielgewicht',
    //                 weight: 60),
    //             currentWeight: Weight(
    //                 id: 'Currentweight',
    //                 date: DateTime(2022, 07, 01),
    //                 title: 'Aktuelles Gewicht',
    //                 weight: 65),
    //              pointSafeDate: DateTime.now(),
    //              gender: Gender.female,
    //              age: 22,
    //              height: 170,
    //              goal: Goal.hold,
    //              movement: Movement.some,
    // )
    //         .toMap());

    AllData.fitpoints =
        FitPoint.forDB().listFromDB(await DBHelper.getData('Fitpoint'));
    AllData.breakfast =
        Breakfast.forDB().listFromDB(await DBHelper.getData('Breakfast'));
    AllData.lunch = Lunch.forDB().listFromDB(await DBHelper.getData('Lunch'));
    AllData.dinner =
        Dinner.forDB().listFromDB(await DBHelper.getData('Dinner'));
    AllData.snack = Snack.forDB().listFromDB(await DBHelper.getData('Snack'));
    AllData.activities =
        Activity.forDB().listFromDB(await DBHelper.getData('Activity'));
    AllData.foods = Food.forDB().listFromDB(await DBHelper.getData('Food'));
    AllData.weighs = Weigh.forDB().listFromDB(await DBHelper.getData('Weigh'));
    AllData.weights =
        Weight.forDB().listFromDB(await DBHelper.getData('Weight'));
    AllData.profiledata =
        ProfileData.forDB().fromDB(await DBHelper.getOneData('Profiledata'));
    AllData.diaries = Diary.forDB().listFromDB(await DBHelper.getData('Diary'));

    await checkPreferences();
    await checkPointSafe();

    return Future.value(true);
  }

  @override
  void initState() {
    dataLoaded = loadAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataLoaded,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const Navigation();
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Future<void> checkPointSafe() async {
    if (Jiffy(AllData.profiledata.pointSafeDate)
        .isBefore(DateTime.now(), Units.DAY)) {
      double points = 0;
      AllData.diaries
          .where((element) =>
              Jiffy(element.date).isBefore(DateTime.now(), Units.DAY) &&
              Jiffy(element.date)
                  .isSameOrAfter(AllData.profiledata.pointSafeDate, Units.DAY))
          .forEach((element) {
        points += element.dailyRestPoints! > 4 ? 4 : element.dailyRestPoints!;
      });
      AllData.profiledata.pointSafe = AllData.profiledata.pointSafe! + points;
      AllData.profiledata.pointSafeDate = DateTime.now();

      await DBHelper.update('Profiledata', AllData.profiledata.toMap());
    }

    if (AllData.prefs.getInt('deletePointsafeDay') ==
        PointSafeDelete.everyMonday.index) {
      if (DateTime.now().weekday == 1) {
        AllData.profiledata.pointSafeDate == DateTime.now();
        AllData.profiledata.pointSafe = 0;
      } else if(
        Jiffy(AllData.profiledata.pointSafe).isBefore(getMondayOfWeek(DateTime.now()), Units.DAY) 
      ){
        AllData.profiledata.pointSafeDate == DateTime.now();
        AllData.profiledata.pointSafe = 0;
      }
    } else if (AllData.prefs.getInt('deletePointsafeDay') ==
        PointSafeDelete.everySunday.index) {
      if (DateTime.now().weekday == 7) {
        AllData.profiledata.pointSafeDate == DateTime.now();
        AllData.profiledata.pointSafe = 0;
      } else if( Jiffy(AllData.profiledata.pointSafeDate!).isBefore(getSundayOfWeek(DateTime.now()), Units.DAY) 
      ){
        AllData.profiledata.pointSafeDate == DateTime.now();
        AllData.profiledata.pointSafe = 0;
      }
    }
  }

  Future<void> checkPreferences() async {
    var prefs = await SharedPreferences.getInstance();

    AllData.prefs = prefs;

    if (prefs.getBool('autoDailypointChange') == null) {
      prefs.setBool('autoDailypointChange', true);
    }

    if (prefs.getInt('deletePointsafeDay') == null) {
      prefs.setInt('deletePointsafeDay', 0);
    }
  }
}
