import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/weight.dart';

class ProfileData {
  String? id;
  String? name;
  String? email;
  double? dailyPoints;
  double? pointSafe;
  DateTime? pointSafeDate;
  Weight? startWeight;
  Weight? targetWeight;
  Weight? currentWeight;
  Gender? gender;
  int? age;
  double? height;
  Movement? movement;
  Goal? goal;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.dailyPoints,
    required this.pointSafe,
    required this.startWeight,
    required this.targetWeight,
    required this.currentWeight,
    required this.gender,
    required this.age,
    required this.height,
    required this.movement,
    required this.goal,
    required this.pointSafeDate,
  });

  ProfileData.forDB();

  // static ProfileData getDummyData() {
  //   return ProfileData(
  //     id: '65465465',
  //     name: 'Jenny',
  //     email: 'jennmei00@yahoo.de',
  //     dailyPoints: 22,
  //     pointSafe: 3,
  //     startWeight: Weight.getDummyDataStart(),
  //     targetWeight: Weight.getDummyDataTarget(),
  //     currentWeight: Weight.getDummyDataCurrent(),
  //     age: null,
  //     gender: null,
  //     goal: null,
  //     height: null,
  //     movement: null,
  //     pointSafeDate: null,
  //   );
  // }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Name'] = name;
    map['Email'] = email;
    map['Dailypoints'] = dailyPoints;
    map['Pointsafe'] = pointSafe;
    map['StartweightID'] = startWeight!.id;
    map['TargetweightID'] = targetWeight!.id;
    map['CurrentweightID'] = currentWeight!.id;
    map['PointSafeDate'] = pointSafeDate.toString();
    map['Age'] = age;
    map['Gender'] = gender!.index;
    map['Goal'] = goal!.index;
    map['Height'] = height;
    map['Movement'] = movement!.index;
    return map;
  }

  // List<ProfileData> listFromDB(List<Map<String, dynamic>> mapList) {
  //   List<ProfileData> list = [];
  //   for (var element in mapList) {
  //     ProfileData profileData = fromDB(element);
  //     list.add(profileData);
  //   }
  //   return list;
  // }

  ProfileData fromDB(Map<String, dynamic> data) {
    ProfileData profileData = ProfileData(
      id: data['ID'],
      name: data['Name'],
      email: data['Email'],
      dailyPoints: data['Dailypoints'],
      pointSafe: data['Pointsafe'],
      startWeight: AllData.weights
          .firstWhere((element) => element.id == data['StartweightID']),
      targetWeight: AllData.weights
          .firstWhere((element) => element.id == data['TargetweightID']),
      currentWeight: AllData.weights
          .firstWhere((element) => element.id == data['CurrentweightID']),
      pointSafeDate: DateTime.parse(data['PointSafeDate']),
      age: data['Age'],
      gender: Gender.values[data['Gender']],
      goal: Goal.values[data['Goal']],
      movement: Movement.values[data['Movement']],
      height: data['Height'],
    );
    return profileData;
  }
}
