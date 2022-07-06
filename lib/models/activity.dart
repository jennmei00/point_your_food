class Activity {
  String id;
  String description;
  double points;

  Activity({
    required this.id,
    required this.description,
    required this.points,
  });

  static List<Activity> getDummyData() {
    return [
      Activity(id: '01Tanzen', description: 'Tanzen', points: 1),
      Activity(id: '02Klettern', description: 'Klettern', points: 2),
      Activity(id: '03Schwimmen', description: 'Schwimmen', points: 1.5),
      Activity(id: '04Yoga', description: 'Yoga', points: 1),
    ];
  }
}
