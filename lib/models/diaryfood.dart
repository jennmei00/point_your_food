class DiaryFood {
  String id;
  String description;
  double points;

  DiaryFood({
    required this.id,
    required this.description,
    required this.points,
  });

  static List<DiaryFood> getDummyDataBreakfast() {
    return [
      DiaryFood(id: '01545123', description: 'Pancakes', points: 3),
    ];
  }

  static List<DiaryFood> getDummyDataLunch() {
    return [
      DiaryFood(id: '6845', description: 'Tomaten', points: 0),
      DiaryFood(id: '75676', description: 'Toastbrot', points: 2),
      DiaryFood(id: '76863', description: 'Butter', points: 4),
    ];
  }

  static List<DiaryFood> getDummyDataDinner() {
    return [
      DiaryFood(id: '6865321', description: 'Spagethi', points: 0.5),
      DiaryFood(id: '6865321', description: 'Tomatensauce', points: 1.5),
      DiaryFood(id: '6865321', description: 'Parmesankäse', points: 2),
    ];
  }
}
