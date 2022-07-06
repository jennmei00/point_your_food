import 'package:punkte_zaehler/models/weight.dart';

class ProfileData {
  String id;
  double dailyPoints;
  double pointSafe;
  Weight startWeight;
  Weight targetWeight;
  Weight currentWeight;

  ProfileData({
    required this.id,
    required this.dailyPoints,
    required this.pointSafe,
    required this.startWeight,
    required this.targetWeight,
    required this.currentWeight,
  });

  static ProfileData getDummyData() {
    return ProfileData(
        id: '65465465',
        dailyPoints: 22,
        pointSafe: 3,
        startWeight: Weight.getDummyDataStart(),
        targetWeight: Weight.getDummyDataTarget(),
        currentWeight: Weight.getDummyDataCurrent());
  }
}
