class Weigh {
  String? id;
  DateTime? date;
  double? weight;

  Weigh({
    required this.id,
    required this.date,
    required this.weight,
  });

  Weigh.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Date'] = date?.toIso8601String();
    map['Weight'] = weight;
    return map;
  }

  List<Weigh> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Weigh> list = [];
    for (var element in mapList) {
      Weigh weigh = fromDB(element);
      list.add(weigh);
    }
    return list;
  }

  Weigh fromDB(Map<String, dynamic> data) {
    Weigh weigh = Weigh(
      id: data['ID'],
      date: DateTime.parse(data['Date']),
      weight: data['Weight'],
    );
    return weigh;
  }
}
