class Food {
  String? id;
  String? title;
  double? points;

  Food({
    required this.id,
    required this.title,
    required this.points,
  });

  Food.forDB();

  static List<Food> getDummyDataBreakfast() {
    return [
      Food(id: '01545123', title: 'Pancakes', points: 3),
    ];
  }

  static List<Food> getDummyDataLunch() {
    return [
      Food(id: '6845', title: 'Tomaten', points: 0),
      Food(id: '75676', title: 'Toastbrot', points: 2),
      Food(id: '76863', title: 'Butter', points: 4),
    ];
  }

  static List<Food> getDummyDataDinner() {
    return [
      Food(id: '6865321', title: 'Spagethi', points: 0.5),
      Food(id: '6865321', title: 'Tomatensauce', points: 1.5),
      Food(id: '6865321', title: 'Parmesankäse', points: 2),
    ];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['Title'] = title;
    map['Points'] = points;
    return map;
  }

  List<Food> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Food> list = [];
    for (var element in mapList) {
      Food food = fromDB(element);
      list.add(food);
    }
    return list;
  }

  Food fromDB(Map<String, dynamic> data) {
    Food food = Food(
      id: data['ID'],
      title: data['Title'],
      points: data['Points'],
    );
    return food;
  }
}
