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
  const EditDiary({Key? key, required this.date, required this.diaryId})
      : super(key: key);
  static const routeName = '/edit_diary';
  // final PointType type;
  final DateTime date;
  final String diaryId;

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
        AllData.diaries.firstWhere((element) => element.id == widget.diaryId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Here');
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(CommunityMaterialIcons.plus_circle,
                        size: 35),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(CommunityMaterialIcons.plus_circle,
                        size: 35),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(CommunityMaterialIcons.plus_circle,
                        size: 35),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    icon: const Icon(CommunityMaterialIcons.plus_circle,
                        size: 35),
                    onPressed: () => addCard(PointType.snack)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteCard(Food obj, PointType type) async {
    dynamic removed;
    if (type == PointType.breakfast) {
      String id = '';
      id = AllData.breakfast
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryId)
          .id!;
      removed = AllData.breakfast.firstWhere((element) => element.id == id);
      AllData.breakfast.remove(removed);
      await DBHelper.delete('Breakfast', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .breakfast!
          .remove(obj);
    } else if (type == PointType.lunch) {
      String id = '';
      id = AllData.lunch
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryId)
          .id!;
      removed = AllData.lunch.firstWhere((element) => element.id == id);
      AllData.lunch.remove(removed);
      DBHelper.delete('Lunch', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .lunch!
          .remove(obj);
    } else if (type == PointType.dinner) {
      String id = '';
      id = AllData.dinner
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryId)
          .id!;
      removed = AllData.dinner.firstWhere((element) => element.id == id);
      AllData.dinner.remove(removed);
      await DBHelper.delete('Dinner', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .dinner!
          .remove(obj);
    } else if (type == PointType.snack) {
      String id = '';
      id = AllData.snack
          .firstWhere((element) =>
              element.foodId == obj.id && element.diaryId == widget.diaryId)
          .id!;
      removed = AllData.snack.firstWhere((element) => element.id == id);
      AllData.snack.remove(removed);
      await DBHelper.delete('Snack', where: 'ID = "$id"');
      // food.remove(obj);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .snack!
          .remove(obj);
    }

    await calcDailyRestPoints(
        add: false, diaryId: widget.diaryId, points: obj.points!);

    setState(() {});

    undoDelete(obj, removed, type);
  }

  addCard(PointType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodSheet(
          type: type,
          diaryId: widget.diaryId,
          onPressed: () async {
            Navigator.of(context).pop();
            setState(() {});
          }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }

  undoDelete(Food obj, dynamic removed, PointType type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Gelöscht'),
        action: SnackBarAction(
          label: 'Rückgängig',
          // textColor: ,
          onPressed: () async {
            if (type == PointType.breakfast) {
              removed as Breakfast;
              AllData.breakfast.add(removed);
              await DBHelper.insert('Breakfast', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryId)
                  .breakfast!
                  .add(obj);
            } else if (type == PointType.lunch) {
              removed as Lunch;
              AllData.lunch.add(removed);
              await DBHelper.insert('Lunch', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryId)
                  .lunch!
                  .add(obj);
            } else if (type == PointType.dinner) {
              removed as Dinner;
              AllData.dinner.add(removed);
              await DBHelper.insert('Dinner', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryId)
                  .dinner!
                  .add(obj);
            } else if (type == PointType.snack) {
              removed as Snack;
              AllData.snack.add(removed);
              await DBHelper.insert('Snack', removed.toMap());
              // food.add(obj);
              AllData.diaries
                  .firstWhere((element) => element.id == widget.diaryId)
                  .snack!
                  .add(obj);
            }
            await calcDailyRestPoints(
                add: true, diaryId: widget.diaryId, points: obj.points!);
            setState(() {});
          },
        )));
  }
}
