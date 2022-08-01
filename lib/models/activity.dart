import 'package:flutter/material.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class Activity {
  String? id;
  String? title;
  double? points;
  IconData? icon;

  Activity({
    required this.id,
    required this.title,
    required this.points,
    required this.icon,
  });

  Activity.forDB();

  // static List<Activity> getDummyData() {
  //   return [
  //     Activity(id: '01Tanzen', title: 'Tanzen', points: 1),
  //     Activity(id: '02Klettern', title: 'Klettern', points: 2),
  //     Activity(id: '03Schwimmen', title: 'Schwimmen', points: 1.5),
  //     Activity(id: '04Yoga', title: 'Yoga', points: 1),
  //   ];
  // }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['Points'] = points;
    map['IconCodePoint'] = icon!.codePoint;
    map['IconFontFamily'] = icon!.fontFamily;
    map['IconPackage'] = icon!.fontPackage;
    map['IconMathTextDirection'] = icon!.matchTextDirection == true ? 1 : 0;
    return map;
  }

  List<Activity> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Activity> list = [];
    for (var element in mapList) {
      Activity activity = fromDB(element);
      list.add(activity);
    }
    return list;
  }

  Activity fromDB(Map<String, dynamic> data) {
    Activity activity = Activity(
      id: data['ID'],
      title: data['Title'],
      points: data['Points'],
      icon: IconData(data['IconCodePoint'],
          fontFamily: data['IconFontFamily'],
          fontPackage: data['IconPackage'],
          matchTextDirection:
              data['IconMathTextDirection'] == 1 ? true : false),
    );
    return activity;
  }
}

class FitPoint {
  String? id;
  String? diaryId;
  String? activityId;
  Duration? duration;
  double? points;

  FitPoint({
    required this.id,
    required this.diaryId,
    required this.activityId,
    required this.duration,
    required this.points,
  });

  FitPoint.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['ActivityID'] = activityId;
    map['Duration'] = duration.toString();
    map['Points'] = points;
    return map;
  }

  List<FitPoint> listFromDB(List<Map<String, dynamic>> mapList) {
    List<FitPoint> list = [];
    for (var element in mapList) {
      FitPoint fitPoint = fromDB(element);
      list.add(fitPoint);
    }
    return list;
  }

  FitPoint fromDB(Map<String, dynamic> data) {
    FitPoint fitPoint = FitPoint(
      id: data['ID'],
      diaryId: data['DiaryID'],
      activityId: data['ActivityID'],
      duration: parseDuration(data['Duration']),
      points: data['Points'],
    );
    return fitPoint;
  }
}
