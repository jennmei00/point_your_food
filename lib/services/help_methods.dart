import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/services/db_helper.dart';

double roundPoints(double points) {
  double result = 0;
  double decimalNumbers =
      double.tryParse('0.${points.toString().split(".").last}')!;

  if (decimalNumbers <= 0.24) {
    result = points.truncateToDouble();
  } else if (decimalNumbers <= 0.74) {
    result = double.tryParse('${points.truncate()}.5')!;
  } else {
    result = points.truncateToDouble() + 1;
  }

  return result;
}

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

String dateFormat(DateTime date) {
  initializeDateFormatting();

  String d = '';
  DateFormat f = DateFormat('dd.MM.yyyy', 'de');
  d = f.format(date);

  return d;
}

String decimalFormat(double num) {
  String d = '';
  NumberFormat f = NumberFormat.decimalPattern('de');
  d = f.format(num);
  return d;
}

double doubleCommaToPoint(String num) {
  double d = 0;
  d = double.parse(num.replaceAll(',', '.'));
  return d;
}

DateTime getMondayOfWeek(DateTime date) {
  DateTime monday;

  switch (Jiffy(date).day) {
    case 1:
      monday = Jiffy(date).subtract(days: 6).dateTime;
      break;
    case 2:
      monday = date;
      break;
    case 3:
      monday = Jiffy(date).subtract(days: 1).dateTime;
      break;
    case 4:
      monday = Jiffy(date).subtract(days: 2).dateTime;
      break;
    case 5:
      monday = Jiffy(date).subtract(days: 3).dateTime;
      break;
    case 6:
      monday = Jiffy(date).subtract(days: 4).dateTime;
      break;
    case 7:
      monday = Jiffy(date).subtract(days: 5).dateTime;
      break;
    default:
      monday = date;
  }
  return monday;
}

DateTime getSundayOfWeek(DateTime date) {
  DateTime sunday;

  switch (Jiffy(date).day) {
    case 1:
      sunday = date;
      break;
    case 2:
      sunday = Jiffy(date).subtract(days: 1).dateTime;
      break;
    case 3:
      sunday = Jiffy(date).subtract(days: 2).dateTime;
      break;
    case 4:
      sunday = Jiffy(date).subtract(days: 3).dateTime;
      break;
    case 5:
      sunday = Jiffy(date).subtract(days: 4).dateTime;
      break;
    case 6:
      sunday = Jiffy(date).subtract(days: 5).dateTime;
      break;
    case 7:
      sunday = Jiffy(date).subtract(days: 6).dateTime;
      break;
    default:
      sunday = date;
  }
  return sunday;
}

double calculateDailypoints({
  required int gender,
  required int age,
  required double weight,
  required double height,
  required int move,
  required int purpose,
}) {
  double points = 0;

  //Male or Female
  if (gender == 0) {
    //male
    points += 15;
  } else {
    //female
    points += 7;
  }

  //Age
  if (age <= 20) {
    points += 5;
  } else if (age <= 35) {
    points += 4;
  } else if (age <= 50) {
    points += 3;
  } else if (age <= 65) {
    points += 2;
  } else {
    points += 1;
  }

  //Weight
  points += (weight / 10).truncate();

  //Height
  if (height < 1.60) {
    points += 1;
  } else {
    points += 2;
  }

  //Move
  if (move == 0) {
    //no move
    points += 0;
  } else if (move == 1) {
    //little move
    points += 2;
  } else if (move == 2) {
    //much move
    points += 4;
  } else if (move == 3) {
    //daily move
    points += 6;
  }

  //purpose
  if (purpose == 0) {
    //hold weight
    points += 4;
  } else {
    //reduce weight
    points += 0;
  }

  return points;
}

Future<void> resestPointsafe() async {
  AllData.profiledata.pointSafe = 0;
  await DBHelper.update('Profiledata', AllData.profiledata.toMap());
}

Future<void> calcDailyRestPoints(
    {required bool add,
    required String diaryId,
    required double points}) async {
  Diary diary = AllData.diaries.firstWhere((element) => element.id == diaryId);

  diary.actualPointSafe ??= AllData.profiledata.pointSafe;

  if (!add) {
    if (Jiffy(diary.date).isBefore(DateTime.now(), Units.DAY)) {
      diary.dailyRestPoints = diary.dailyRestPoints! + points;
    } else {
      diary.dailyRestPoints = diary.dailyRestPoints! + points;

      if (diary.dailyRestPoints! >= 0) {
        if (diary.dailyRestPoints! <=
            diary.actualPointSafe! - AllData.profiledata.pointSafe!) {
          AllData.profiledata.pointSafe =
              AllData.profiledata.pointSafe! + diary.dailyRestPoints!;

          diary.dailyRestPoints = 0;
        } else {
          diary.dailyRestPoints = diary.dailyRestPoints! -
              (diary.actualPointSafe! - AllData.profiledata.pointSafe!);
          AllData.profiledata.pointSafe = diary.actualPointSafe!;
        }
      }
    }
  } else {
    if (Jiffy(diary.date).isBefore(DateTime.now(), Units.DAY)) {
      diary.dailyRestPoints = diary.dailyRestPoints! - points;
    } else {
      if (diary.dailyRestPoints! < points) {
        if (AllData.profiledata.pointSafe! >=
            (points - diary.dailyRestPoints!)) {
          AllData.profiledata.pointSafe = AllData.profiledata.pointSafe! -
              (points - diary.dailyRestPoints!);
          diary.dailyRestPoints = 0;
        } else {
          diary.dailyRestPoints = diary.dailyRestPoints! -
              (points - AllData.profiledata.pointSafe!);
          AllData.profiledata.pointSafe = 0;
        }
      } else {
        diary.dailyRestPoints = diary.dailyRestPoints! - points;
      }
    }

    AllData.diaries
        .firstWhere((element) => element.id == diaryId)
        .dailyRestPoints = diary.dailyRestPoints;
  }

  await DBHelper.update('Diary',
      AllData.diaries.firstWhere((element) => element.id == diaryId).toMap(),
      where: 'ID = "$diaryId"');
}
