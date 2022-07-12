import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/models/foods.dart';
import 'package:punkte_zaehler/models/profiledata.dart';
import 'package:punkte_zaehler/models/weigh.dart';
import 'package:punkte_zaehler/models/weight.dart';
import 'package:punkte_zaehler/screens/navigation.dart';
import 'package:punkte_zaehler/services/db_helper.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late Future<bool> dataLoaded;

  Future<bool> loadAllData() async {
    AllData.fitpoints = FitPoint.forDB().listFromDB(await DBHelper.getData('Fitpoint'));
    AllData.breakfast =
        Breakfast.forDB().listFromDB(await DBHelper.getData('Breakfast'));
    AllData.lunch = Lunch.forDB().listFromDB(await DBHelper.getData('Lunch'));
    AllData.dinner = Dinner.forDB().listFromDB(await DBHelper.getData('Dinner'));
    AllData.snack = Snack.forDB().listFromDB(await DBHelper.getData('Snack'));
    AllData.activities = Activity.forDB().listFromDB(await DBHelper.getData('Activity'));
    AllData.foods = Food.forDB().listFromDB(await DBHelper.getData('Food'));
    AllData.weighs = Weigh.forDB().listFromDB(await DBHelper.getData('Weigh'));
    AllData.weights = Weight.forDB().listFromDB(await DBHelper.getData('Weight'));
    AllData.profiledata = ProfileData.forDB().fromDB(await DBHelper.getOneData('Profiledata'));
    AllData.diaries = Diary.forDB().listFromDB(await DBHelper.getData('Diary'));

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
}
