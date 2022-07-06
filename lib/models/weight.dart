class Weight {
  String id;
  String description;
  DateTime date;
  double weight;

  Weight({
    required this.id,
    required this.description,
    required this.date,
    required this.weight,
  });

  static Weight getDummyDataStart() {
    return Weight(id: '654654321', description: 'Startgewicht', date: DateTime(2022,6,10), weight: 70.5);
  }

  static Weight getDummyDataTarget() {
    return Weight(id: '654654321', description: 'Startgewicht', date: DateTime(2022,7,30), weight: 60);
  }

  static Weight getDummyDataCurrent() {
    return Weight(id: '654654321', description: 'Startgewicht', date: DateTime(2022,7,6), weight: 66.25);
  }
}
