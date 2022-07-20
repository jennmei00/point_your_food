class Weight {
  String? id;
  String? title;
  DateTime? date;
  double? weight;

  Weight({
    required this.id,
    required this.title,
    required this.date,
    required this.weight,
  });

  Weight.forDB();

  static Weight getDummyDataStart() {
    return Weight(
        id: '654654321',
        title: 'Startgewicht',
        date: DateTime(2022, 6, 10),
        weight: 70.5);
  }

  static Weight getDummyDataTarget() {
    return Weight(
        id: '654654321',
        title: 'Startgewicht',
        date: DateTime(2022, 7, 30),
        weight: 60);
  }

  static Weight getDummyDataCurrent() {
    return Weight(
        id: '654654321',
        title: 'Startgewicht',
        date: DateTime(2022, 7, 6),
        weight: 66.25);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['Date'] = date!.toIso8601String();
    map['Weight'] = weight;
    return map;
  }

  List<Weight> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Weight> list = [];
    for (var element in mapList) {
      Weight weight = fromDB(element);
      list.add(weight);
    }
    return list;
  }

  Weight fromDB(Map<String, dynamic> data) {
    Weight weight = Weight(
      id: data['ID'],
      title: data['Title'],
      date: DateTime.parse(data['Date']),
      weight: data['Weight'] == null ? 0 : data['Weight'] as double,
    );
    return weight;
  }
}
