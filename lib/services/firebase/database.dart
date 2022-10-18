// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:punkte_zaehler/models/activity.dart';
// import 'package:punkte_zaehler/models/all_data.dart';

// class DatabaseService {
//   final String uid;
//   DatabaseService({required this.uid});

//   //add document
//   //db.collection("activities").doc("NEW_ID").set(MAP_Activity)

//   //update document
//   //reference = db.collection("activities").doc("ID")
//   //reference.update(MAP_Activity)

//   //delete document
//   //db.collection("activities").doc("ID").delete()

//   //get document
//   //reference = db.collection("activities").doc("ID")
//   //reference.get()

//   //get collection
//   //reference = db.collection("activities")
//   //reference.get()

//   final FirebaseFirestore store = FirebaseFirestore.instance;

//   // collection references
//   // CollectionReference? _actvityCollection;
//   // DocumentReference? userReference;

//   final CollectionReference userCollection =
//       FirebaseFirestore.instance.collection('user');

//   DocumentReference get userReference {
//     return store.doc(uid);
//   }

//   CollectionReference get activityCollection {
//     return store.collection('user/$uid/activities');
//   }

//   CollectionReference get fitpointCollection {
//     return store.collection('user/$uid/fitpoints');
//   }

//   CollectionReference get diaryCollection {
//     return store.collection('user/$uid/diaries');
//   }

//   CollectionReference get breakfastCollection {
//     return store.collection('user/$uid/breakfast');
//   }

//   CollectionReference get lunchCollection {
//     return store.collection('user/$uid/lunch');
//   }

//   CollectionReference get dinnerCollection {
//     return store.collection('user/$uid/dinner');
//   }

//   CollectionReference get snackCollection {
//     return store.collection('user/$uid/snack');
//   }

//   CollectionReference get foodCollection {
//     return store.collection('user/$uid/food');
//   }

//   loadToAllData() async {
//     AllData.fitpoints =
//         FitPoint.forDB().listFromFirestore(await fitpointCollection.get());
//     // AllData.fitpoints =
//     //     FitPoint.forDB().listFromDB(await DBHelper.getData('Fitpoint'));
//     // AllData.breakfast =
//     //     Breakfast.forDB().listFromDB(await DBHelper.getData('Breakfast'));
//     // AllData.lunch = Lunch.forDB().listFromDB(await DBHelper.getData('Lunch'));
//     // AllData.dinner =
//     //     Dinner.forDB().listFromDB(await DBHelper.getData('Dinner'));
//     // AllData.snack = Snack.forDB().listFromDB(await DBHelper.getData('Snack'));
//     // AllData.activities =
//     //     Activity.forDB().listFromDB(await DBHelper.getData('Activity'));
//     // AllData.foods = Food.forDB().listFromDB(await DBHelper.getData('Food'));
//     // AllData.weighs = Weigh.forDB().listFromDB(await DBHelper.getData('Weigh'));
//     // AllData.weights =
//     //     Weight.forDB().listFromDB(await DBHelper.getData('Weight'));
//     // AllData.profiledata =
//     //     ProfileData.forDB().fromDB(await DBHelper.getOneData('Profiledata'));
//     // AllData.diaries = Diary.forDB().listFromDB(await DBHelper.getData('Diary'));
//   }
//   // Stream<List<Activity>> get activites {
//   //   return activityCollection
//   //       .snapshots()
//   //       .map(Activity.forDB().activityListFromSnapshot);
//   // }
// }
