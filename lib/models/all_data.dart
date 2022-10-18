import 'package:punkte_zaehler/auth/user.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/models/foods.dart';
import 'package:punkte_zaehler/models/profiledata.dart';
import 'package:punkte_zaehler/models/weigh.dart';
import 'package:punkte_zaehler/models/weight.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activity.dart';
import 'diary.dart';

class AllData {
  static late List<Activity> activities;
  static late List<Diary> diaries;
  static late List<Breakfast> breakfast;
  static late List<Lunch> lunch;
  static late List<Dinner> dinner;
  static late List<Snack> snack;
  static late List<Food> foods;
  static late List<Weigh> weighs;
  static late List<Weight> weights;
  static late List<FitPoint> fitpoints;
  static late ProfileData profiledata;
  static late SharedPreferences prefs;
  // static late UserAuth user;
}
