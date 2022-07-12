class Activity {
  String? id;
  String? title;
  double? points;

  Activity({
    required this.id,
    required this.title,
    required this.points,
  });

  Activity.forDB();

  static List<Activity> getDummyData() {
    return [
      Activity(id: '01Tanzen', title: 'Tanzen', points: 1),
      Activity(id: '02Klettern', title: 'Klettern', points: 2),
      Activity(id: '03Schwimmen', title: 'Schwimmen', points: 1.5),
      Activity(id: '04Yoga', title: 'Yoga', points: 1),
    ];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['Points'] = points;
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
    );
    return activity;
  }
}

class FitPoint {
  String? id;
  String? diaryId;
  String? activityId;

  FitPoint({
    required this.id,
    required this.diaryId,
    required this.activityId,
  });

  FitPoint.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['ActivityID'] = activityId;
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
    );
    return fitPoint;
  }
}
