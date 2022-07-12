import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/weight.dart';

class ProfileData {
  String? id;
  String? name;
  String? email;
  double? dailyPoints;
  double? pointSafe;
  Weight? startWeight;
  Weight? targetWeight;
  Weight? currentWeight;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.dailyPoints,
    required this.pointSafe,
    required this.startWeight,
    required this.targetWeight,
    required this.currentWeight,
  });

  ProfileData.forDB();

  static ProfileData getDummyData() {
    return ProfileData(
        id: '65465465',
        name: 'Jenny',
        email: 'jennmei00@yahoo.de',
        dailyPoints: 22,
        pointSafe: 3,
        startWeight: Weight.getDummyDataStart(),
        targetWeight: Weight.getDummyDataTarget(),
        currentWeight: Weight.getDummyDataCurrent());
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Name'] = name;
    map['Email'] = email;
    map['Dialypoints'] = dailyPoints;
    map['Pointsafe'] = pointSafe;
    map['Startweight'] = startWeight!.id;
    map['Targetweight'] = targetWeight!.id;
    map['Currentweight'] = currentWeight!.id;
    return map;
  }

  List<ProfileData> listFromDB(List<Map<String, dynamic>> mapList) {
    List<ProfileData> list = [];
    for (var element in mapList) {
      ProfileData profileData = fromDB(element);
      list.add(profileData);
    }
    return list;
  }

  ProfileData fromDB(Map<String, dynamic> data) {
    ProfileData profileData = ProfileData(
      id: data['ID'],
      name: data['Name'],
      email: data['Email'],
      dailyPoints: double.parse(data['Dialypoints']),
      pointSafe: double.parse(data['Pointsafe']),
      startWeight: AllData.weights
          .firstWhere((element) => element.id == data['Startweight']),
      targetWeight: AllData.weights
          .firstWhere((element) => element.id == data['Targetweight']),
      currentWeight: AllData.weights
          .firstWhere((element) => element.id == data['Currentweight']),
    );
    return profileData;
  }
}
