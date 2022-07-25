import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/food.dart';

class Diary {
  String? id;
  DateTime? date;
  double? dailyRestPoints;
  List<Food>? breakfast;
  List<Food>? lunch;
  List<Food>? dinner;
  List<Food>? snack;
  List<Activity>? fitpoints;

  Diary({
    required this.id,
    required this.date,
    required this.dailyRestPoints,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snack,
    required this.fitpoints,
  });

  Diary.forDB();

  static List<Diary> getDummyData() {
    return [
      Diary(
          id: '256486',
          date: DateTime(2022, 7, 6),
          dailyRestPoints: 5,
          breakfast: Food.getDummyDataBreakfast(),
          lunch: Food.getDummyDataLunch(),
          dinner: Food.getDummyDataDinner(),
          fitpoints: Activity.getDummyData(),
          snack: Food.getDummyDataBreakfast()),
      Diary(
          id: '256487',
          date: DateTime(2022, 7, 5),
          dailyRestPoints: 0,
          breakfast: Food.getDummyDataBreakfast(),
          lunch: Food.getDummyDataLunch(),
          dinner: Food.getDummyDataDinner(),
          fitpoints: Activity.getDummyData(),
          snack: Food.getDummyDataBreakfast()),
      Diary(
          id: '256488',
          date: DateTime(2022, 7, 4),
          dailyRestPoints: 2,
          breakfast: Food.getDummyDataBreakfast(),
          lunch: Food.getDummyDataLunch(),
          dinner: Food.getDummyDataDinner(),
          fitpoints: Activity.getDummyData(),
          snack: Food.getDummyDataBreakfast()),
    ];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Date'] = date!.toIso8601String();
    map['Dailyrestpoints'] = dailyRestPoints;
    return map;
  }

  List<Diary> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Diary> list = [];
    for (var element in mapList) {
      Diary diary = fromDB(element);
      list.add(diary);
    }
    return list;
  }

  Diary fromDB(Map<String, dynamic> data) {
    Diary diary = Diary(
      id: data['ID'],
      date: DateTime.parse(data['Date']),
      dailyRestPoints: data['Dailyrestpoints'],
      breakfast: _getFood(AllData.breakfast
          .where((element) => element.diaryId == data['ID'])
          .toList()),
      lunch: _getFood(AllData.lunch
          .where((element) => element.diaryId == data['ID'])
          .toList()),
      dinner: _getFood(AllData.dinner
          .where((element) => element.diaryId == data['ID'])
          .toList()),
      snack: _getFood(AllData.snack
          .where((element) => element.diaryId == data['ID'])
          .toList()),
      fitpoints: _getActivity(AllData.fitpoints
          .where((element) => element.diaryId == data['ID'])
          .toList()),
    );
    return diary;
  }

  List<Food> _getFood(List<dynamic> foodList) {
    List<Food> food = [];

    for (var element in foodList) {
      food.addAll(AllData.foods.where((val) => val.id == element.foodId));
    }

    return food;
  }

  List<Activity> _getActivity(List<FitPoint> foodList) {
    List<Activity> activities = [];

    for (var element in foodList) {
      activities.addAll(
          AllData.activities.where((val) => val.id == element.activityId));
    }

    return activities;
  }
}
