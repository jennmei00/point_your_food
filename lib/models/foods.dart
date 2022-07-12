class Breakfast {
  String? id;
  String? diaryId;
  String? foodId;

  Breakfast({
    required this.id,
    required this.diaryId,
    required this.foodId,
  });

  Breakfast.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['FoodID'] = foodId;
    return map;
  }

  List<Breakfast> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Breakfast> list = [];
    for (var element in mapList) {
      Breakfast breakfast = fromDB(element);
      list.add(breakfast);
    }
    return list;
  }

  Breakfast fromDB(Map<String, dynamic> data) {
    Breakfast breakfast = Breakfast(
      id: data['ID'],
      diaryId: data['DiaryID'],
      foodId: data['FoodID'],
    );
    return breakfast;
  }
}

class Lunch {
  String? id;
  String? diaryId;
  String? foodId;

  Lunch({
    required this.id,
    required this.diaryId,
    required this.foodId,
  });

  Lunch.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['FoodID'] = foodId;
    return map;
  }

  List<Lunch> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Lunch> list = [];
    for (var element in mapList) {
      Lunch lunch = fromDB(element);
      list.add(lunch);
    }
    return list;
  }

  Lunch fromDB(Map<String, dynamic> data) {
    Lunch lunch = Lunch(
      id: data['ID'],
      diaryId: data['DiaryID'],
      foodId: data['FoodID'],
    );
    return lunch;
  }
}

class Dinner {
  String? id;
  String? diaryId;
  String? foodId;

  Dinner({
    required this.id,
    required this.diaryId,
    required this.foodId,
  });

  Dinner.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['FoodID'] = foodId;
    return map;
  }

  List<Dinner> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Dinner> list = [];
    for (var element in mapList) {
      Dinner dinner = fromDB(element);
      list.add(dinner);
    }
    return list;
  }

  Dinner fromDB(Map<String, dynamic> data) {
    Dinner dinner = Dinner(
      id: data['ID'],
      diaryId: data['DiaryID'],
      foodId: data['FoodID'],
    );
    return dinner;
  }
}

class Snack {
  String? id;
  String? diaryId;
  String? foodId;

  Snack({
    required this.id,
    required this.diaryId,
    required this.foodId,
  });

  Snack.forDB();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['ID'] = id;
    map['DiaryID'] = diaryId;
    map['FoodID'] = foodId;
    return map;
  }

  List<Snack> listFromDB(List<Map<String, dynamic>> mapList) {
    List<Snack> list = [];
    for (var element in mapList) {
      Snack snack = fromDB(element);
      list.add(snack);
    }
    return list;
  }

  Snack fromDB(Map<String, dynamic> data) {
    Snack snack = Snack(
      id: data['ID'],
      diaryId: data['DiaryID'],
      foodId: data['FoodID'],
    );
    return snack;
  }
}
