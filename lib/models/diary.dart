import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/diaryfood.dart';

class Diary {
  String id;
  DateTime date;
  double dailyRestPoints;
  List<DiaryFood> breakfast;
  List<DiaryFood> lunch;
  List<DiaryFood> dinner;
  List<Activity> activity;

  Diary({
    required this.id,
    required this.date,
    required this.dailyRestPoints,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.activity,
  });

  List<Diary> getDummyData() {
    return [
      Diary(
          id: '256486',
          date: DateTime(2022, 7, 6),
          dailyRestPoints: 5,
          breakfast: DiaryFood.getDummyDataBreakfast(),
          lunch: DiaryFood.getDummyDataLunch(),
          dinner: DiaryFood.getDummyDataDinner(),
          activity: Activity.getDummyData()),
      Diary(
          id: '256487',
          date: DateTime(2022, 7, 5),
          dailyRestPoints: 0,
          breakfast: DiaryFood.getDummyDataBreakfast(),
          lunch: DiaryFood.getDummyDataLunch(),
          dinner: DiaryFood.getDummyDataDinner(),
          activity: Activity.getDummyData()),
      Diary(
          id: '256488',
          date: DateTime(2022, 7, 4),
          dailyRestPoints: 2,
          breakfast: DiaryFood.getDummyDataBreakfast(),
          lunch: DiaryFood.getDummyDataLunch(),
          dinner: DiaryFood.getDummyDataDinner(),
          activity: Activity.getDummyData())
    ];
  }
}
