import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/models/foods.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/diary/add_food_sheet.dart';

class EditDiary extends StatefulWidget {
  const EditDiary({Key? key, required this.date, required this.diaryID})
      : super(key: key);
  static const routeName = '/edit_diary';
  // final PointType type;
  final DateTime date;
  final String diaryID;

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  // List<Food> food = [];
  // List<Activity> activity = [];
  // double points = 0;
  Diary? diary;

  @override
  void initState() {
    // getData();
    diary =
        AllData.diaries.firstWhere((element) => element.id == widget.diaryID);

    super.initState();
  }

  void getData() {
    // food = [];
    // activity = [];

    // if (widget.type == PointType.breakfast) {
    //   List<Breakfast> breakfast = AllData.breakfast
    //       .where((element) => element.diaryId == widget.diaryID)
    //       .toList();
    //   for (var f in AllData.foods) {
    //     for (var b in breakfast) {
    //       if (f.id == b.foodId) {
    //         food.add(f);
    //       }
    //     }
    //   }
    // } else if (widget.type == PointType.lunch) {
    //   List<Lunch> lunch = AllData.lunch
    //       .where((element) => element.diaryId == widget.diaryID)
    //       .toList();
    //   for (var f in AllData.foods) {
    //     for (var l in lunch) {
    //       if (f.id == l.foodId) {
    //         food.add(f);
    //       }
    //     }
    //   }
    // } else if (widget.type == PointType.dinner) {
    //   List<Dinner> dinner = AllData.dinner
    //       .where((element) => element.diaryId == widget.diaryID)
    //       .toList();
    //   for (var f in AllData.foods) {
    //     for (var d in dinner) {
    //       if (f.id == d.foodId) {
    //         food.add(f);
    //       }
    //     }
    //   }
    // } else if (widget.type == PointType.snack) {
    //   List<Snack> snack = AllData.snack
    //       .where((element) => element.diaryId == widget.diaryID)
    //       .toList();
    //   for (var f in AllData.foods) {
    //     for (var s in snack) {
    //       if (f.id == s.foodId) {
    //         food.add(f);
    //       }
    //     }
    //   }
    // } else if (widget.type == PointType.activity) {
    //   List<FitPoint> fitpoint = AllData.fitpoints
    //       .where((element) => element.diaryId == widget.diaryID)
    //       .toList();
    //   for (var a in AllData.activities) {
    //     for (var f in fitpoint) {
    //       if (a.id == f.activityId) {
    //         activity.add(a);
    //       }
    //     }
    //   }
    // }
    // calcPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Essen bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: const [
                Icon(
                  CommunityMaterialIcons.coffee,
                  size: 40,
                ),
                Text(
                  '  Frühstück',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Column(
              children: diary!.breakfast!
                  .map((e) => ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.title!),
                                Text('${decimalFormat(e.points!)} P.'),
                              ]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(CommunityMaterialIcons.delete),
                          onPressed: () => deleteCard(e, PointType.breakfast),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon:
                      const Icon(CommunityMaterialIcons.plus_circle, size: 35),
                  onPressed: () => addCard(PointType.breakfast)),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: Colors.black,
            ),
            Row(
              children: const [
                Icon(
                  CommunityMaterialIcons.baguette,
                  size: 40,
                ),
                Text(
                  '  Mittag',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Column(
              children: diary!.lunch!
                  .map((e) => ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.title!),
                                Text('${decimalFormat(e.points!)} P.'),
                              ]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(CommunityMaterialIcons.delete),
                          onPressed: () => deleteCard(e, PointType.lunch),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon:
                      const Icon(CommunityMaterialIcons.plus_circle, size: 35),
                  onPressed: () => addCard(PointType.lunch)),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: Colors.black,
            ),
            Row(
              children: const [
                Icon(
                  CommunityMaterialIcons.noodles,
                  size: 40,
                ),
                Text(
                  '  Abend',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Column(
              children: diary!.dinner!
                  .map((e) => ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.title!),
                                Text('${decimalFormat(e.points!)} P.'),
                              ]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(CommunityMaterialIcons.delete),
                          onPressed: () => deleteCard(e, PointType.dinner),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon:
                      const Icon(CommunityMaterialIcons.plus_circle, size: 35),
                  onPressed: () => addCard(PointType.dinner)),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: Colors.black,
            ),
            Row(
              children: const [
                Icon(
                  CommunityMaterialIcons.candycane,
                  size: 40,
                ),
                Text(
                  '  Snack',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Column(
              children: diary!.snack!
                  .map((e) => ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.title!),
                                Text('${decimalFormat(e.points!)} P.'),
                              ]),
                        ),
                        trailing: IconButton(
                          icon: const Icon(CommunityMaterialIcons.delete),
                          onPressed: () => deleteCard(e, PointType.snack),
                        ),
                      ))
                  .toList(),
            ),
            Align(
              alignment: Alignment.center,
              child: IconButton(
                  icon:
                      const Icon(CommunityMaterialIcons.plus_circle, size: 35),
                  onPressed: () => addCard(PointType.snack)),
            ),
          ],
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: Column(children: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           widget.type == PointType.breakfast
      //               ? 'Frühstück'
      //               : widget.type == PointType.lunch
      //                   ? 'Mittag'
      //                   : widget.type == PointType.dinner
      //                       ? 'Abend'
      //                       : widget.type == PointType.snack
      //                           ? 'Snack'
      //                           : 'Fitpunkte',
      //           style:
      //               const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //         ),
      //         Text('$points Punkte Gesamt'),
      //       ],
      //     ),
      //     const SizedBox(height: 10),
      //     Expanded(
      //       child: ListView(
      //           children: widget.type == 'activity'
      //               ? activity
      //                   .map(
      //                     (e) => Card(
      //                       elevation: 5,
      //                       child: ListTile(
      //                         title: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text('${e.title}'),
      //                             Text('${e.points}')
      //                           ],
      //                         ),
      //                         trailing: IconButton(
      //                             icon: const Icon(
      //                               Icons.delete,
      //                               color: Color.fromARGB(255, 216, 77, 67),
      //                             ),
      //                             onPressed: () => deleteCard(e)),
      //                       ),
      //                     ),
      //                   )
      //                   .toList()
      //               : food
      //                   .map(
      //                     (e) => Card(
      //                       elevation: 5,
      //                       child: ListTile(
      //                         title: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text('${e.title}'),
      //                             Text('${e.points}')
      //                           ],
      //                         ),
      //                         trailing: IconButton(
      //                             icon: const Icon(
      //                               Icons.delete,
      //                               color: Color.fromARGB(255, 216, 77, 67),
      //                             ),
      //                             onPressed: () => deleteCard(e)),
      //                       ),
      //                     ),
      //                   )
      //                   .toList()
      //           // [
      //           // Card(
      //           //   elevation: 5,
      //           //   child: ListTile(
      //           //     title: Row(
      //           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //       children: const [Text('Pencake'), Text('1.5')],
      //           //     ),
      //           //     trailing: IconButton(
      //           //         icon: const Icon(
      //           //           Icons.delete,
      //           //           color: Color.fromARGB(255, 216, 77, 67),
      //           //         ),
      //           //         onPressed: () => deleteCard()),
      //           //   ),
      //           // ),
      //           //   Card(
      //           //     elevation: 5,
      //           //     child: ListTile(
      //           //       title: Row(
      //           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //         children: const [Text('Pencake'), Text('1.5')],
      //           //       ),
      //           //       trailing: IconButton(
      //           //           icon: const Icon(
      //           //             Icons.delete,
      //           //             color: Color.fromARGB(255, 216, 77, 67),
      //           //           ),
      //           //           onPressed: () => deleteCard()),
      //           //     ),
      //           //   ),
      //           //   Card(
      //           //     elevation: 5,
      //           //     child: ListTile(
      //           //       title: Row(
      //           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //         children: const [Text('Ei'), Text('1.0')],
      //           //       ),
      //           //       trailing: IconButton(
      //           //           icon: const Icon(
      //           //             Icons.delete,
      //           //             color: Color.fromARGB(255, 216, 77, 67),
      //           //           ),
      //           //           onPressed: () => deleteCard()),
      //           //     ),
      //           //   ),
      //           // Row(
      //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //   children: [
      //           //     const SizedBox(),
      //           //     OutlinedButton(
      //           //         onPressed: () => addCard(),
      //           //         child: Row(
      //           //           children: const [
      //           //             Icon(Icons.add),
      //           //             Text(' Hinzufügen')
      //           //           ],
      //           //         )),
      //           //   ],
      //           // )
      //           // ],
      //           ),
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         const SizedBox(),
      //         OutlinedButton(
      //             onPressed: () => addCard(),
      //             child: Row(
      //               children: const [Icon(Icons.add), Text(' Hinzufügen')],
      //             )),
      //       ],
      //     )
      //   ]),
      // ),
    );
  }

  deleteCard(Food obj, PointType type) async {
    dynamic removed;
    if (type == PointType.breakfast) {
      String id = '';
      id = AllData.breakfast
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryID)
          .id!;
      removed = AllData.breakfast.firstWhere((element) => element.id == id);
      AllData.breakfast.remove(removed);
      await DBHelper.delete('Breakfast', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .breakfast!
          .remove(obj);
    } else if (type == PointType.lunch) {
      String id = '';
      id = AllData.lunch
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryID)
          .id!;
      removed = AllData.lunch.firstWhere((element) => element.id == id);
      AllData.lunch.remove(removed);
      DBHelper.delete('Lunch', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .lunch!
          .remove(obj);
    } else if (type == PointType.dinner) {
      String id = '';
      id = AllData.dinner
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryID)
          .id!;
      removed = AllData.dinner.firstWhere((element) => element.id == id);
      AllData.dinner.remove(removed);
      await DBHelper.delete('Dinner', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .dinner!
          .remove(obj);
    } else if (type == PointType.snack) {
      String id = '';
      id = AllData.snack
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryID)
          .id!;
      removed = AllData.snack.firstWhere((element) => element.id == id);
      AllData.snack.remove(removed);
      await DBHelper.delete('Snack', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .snack!
          .remove(obj);
    }
    await calcDialyRestPoints(obj, false);
    getData();
    setState(() {});

    undoDelete(obj, removed, type);
  }

  Future<void> calcDialyRestPoints(Food obj, bool add) async {
    if (!add) {
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .dailyRestPoints = AllData.diaries
              .firstWhere((element) => element.id == widget.diaryID)
              .dailyRestPoints! +
          obj.points!;
    } else {
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryID)
          .dailyRestPoints = AllData.diaries
              .firstWhere((element) => element.id == widget.diaryID)
              .dailyRestPoints! -
          obj.points!;
    }

    await DBHelper.update(
        'Diary',
        AllData.diaries
            .firstWhere((element) => element.id == widget.diaryID)
            .toMap(),
        where: 'ID = "${widget.diaryID}"');
  }

  addCard(PointType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodSheet(
          type: type,
          diaryId: widget.diaryID,
          onPressed: () async {
            Navigator.of(context).pop();
            getData();
            setState(() {});
          }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }

  // void calcPoints() {
  //   points = 0;
  //   if (widget.type == PointType.activity) {
  //     for (var element in activity) {
  //       points += element.points!;
  //     }
  //   } else {
  //     for (var element in food) {
  //       points += element.points!;
  //     }
  //   }

  undoDelete(Food obj, dynamic removed, PointType type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Gelöscht'),
        action: SnackBarAction(
          label: 'Rückgängig',
          onPressed: () async {
            if (type == PointType.breakfast) {
              removed as Breakfast;
              AllData.breakfast.add(removed);
              await DBHelper.insert('Breakfast', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryID)
                  .breakfast!
                  .add(obj);
            } else if (type == PointType.lunch) {
              removed as Lunch;
              AllData.lunch.add(removed);
              await DBHelper.insert('Lunch', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryID)
                  .lunch!
                  .add(obj);
            } else if (type == PointType.dinner) {
              removed as Dinner;
              AllData.dinner.add(removed);
              await DBHelper.insert('Dinner', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryID)
                  .dinner!
                  .add(obj);
            } else if (type == PointType.snack) {
              removed as Snack;
              AllData.snack.add(removed);
              await DBHelper.insert('Snack', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryID)
                  .snack!
                  .add(obj);
            }
            await calcDialyRestPoints(obj, true);
            getData();
            setState(() {});
          },
        )));
  }
}
