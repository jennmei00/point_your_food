import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/screens/diary/activities.dart';
import 'package:punkte_zaehler/screens/diary/edit_diary.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/services/theme.dart';
import 'package:punkte_zaehler/widgets/diary/activity_card.dart';
import 'package:punkte_zaehler/widgets/diary/add_food_sheet.dart';
import 'package:punkte_zaehler/widgets/diary/food_card.dart';
import 'package:uuid/uuid.dart';

class FoodDiary extends StatefulWidget {
  const FoodDiary({Key? key}) : super(key: key);

  @override
  State<FoodDiary> createState() => _FoodDiaryState();
}

class _FoodDiaryState extends State<FoodDiary> {
  Diary diary = Diary(
      id: 'null',
      date: DateTime.now(),
      dailyRestPoints: AllData.profiledata.dailyPoints,
      actualPointSafe: AllData.profiledata.pointSafe,
      breakfast: [],
      lunch: [],
      dinner: [],
      activities: [],
      fitpoints: [],
      snack: []);
  DateTime initDate = DateTime.now();
  GlobalKey<FlipCardState> cardKeyBreakfast = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeyLunch = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeyDinner = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeySnack = GlobalKey<FlipCardState>();
  // bool editDisabled = false;

  @override
  void initState() {
    onDateSelected(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // editDisabled = Jiffy(diary.date)
    //     .isBefore(DateTime.now().subtract(const Duration(days: 1)), Units.DAY);

    // print(diary.dailyRestPoints);
    // print(diary.actualPointSafe);
    // AllData.diaries.firstWhere((element) => element == diary).actualPointSafe = 3;
    // AllData.diaries.firstWhere((element) => element == diary).dailyRestPoints = 2;
    // AllData.profiledata.pointSafe = 3;

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        CalendarTimeline(
          initialDate: initDate,
          firstDate: Jiffy(DateTime.now()).subtract(years: 1).dateTime,
          lastDate: Jiffy(DateTime.now()).add(months: 1).dateTime,
          onDateSelected: (date) => onDateSelected(date),
          leftMargin: 20,
          // dayColor: calenderDayColor,
          // activeDayColor: calenderActiveDayColor,
          // activeBackgroundDayColor: calenderActiveBackgroundDayColor,
          // dotsColor: calenderDotsColor,
          showYears: true,
          locale: 'de',
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    'Heute übrig:\n${decimalFormat(diary.dailyRestPoints!)} Punkte',
                    style: TextStyle(
                        color: diary.dailyRestPoints!.isNegative
                            ? Colors.red
                            : Colors.black),
                  )), //diary.dailyRestPoints! < 0 && AllData.profiledata.pointSafe != 0 ? 0 :
              Expanded(
                child: Text(
                    'Punktetresor:\n${decimalFormat(AllData.profiledata.pointSafe!)} Punkte'),
              )
            ],
          ),
        ),
        const Divider(
            thickness: 2, color: Colors.black, indent: 10, endIndent: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Essen',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap:
                        // editDisabled
                        //     ? null
                        //     :
                        () => onEditPressed(0, initDate, context, diary),
                    child: Row(
                      children: const [
                        Text('Bearbeiten',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color:
                                    // editDisabled ? Colors.grey :
                                    Colors.black)),
                        Icon(Icons.arrow_right_alt_outlined,
                            color:
                                // editDisabled ? Colors.grey :
                                Colors.black)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 215,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 15),
                  children: [
                    FoodCard(
                      diary: diary,
                      type: PointType.breakfast,
                      title: 'Frühstück',
                      icon: CommunityMaterialIcons.coffee,
                      food: diary.breakfast!,
                      color: breakfastCardColor,
                      onAddPressed:
                          // editDisabled
                          //     ? null
                          //     :
                          () => addCard(PointType.breakfast),
                      cardKey: cardKeyBreakfast,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.lunch,
                      title: 'Mittag',
                      icon: CommunityMaterialIcons.baguette,
                      food: diary.lunch!,
                      color: lunchCardColor,
                      onAddPressed:
                          // editDisabled ? null :
                          () => addCard(PointType.lunch),
                      cardKey: cardKeyLunch,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.dinner,
                      title: 'Abend',
                      icon: CommunityMaterialIcons.pasta,
                      food: diary.dinner!,
                      color: dinnerCardColor,
                      onAddPressed:
                          // editDisabled ? null :
                          () => addCard(PointType.dinner),
                      cardKey: cardKeyDinner,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.snack,
                      title: 'Snack',
                      icon: CommunityMaterialIcons.cake_layered,
                      food: diary.snack!,
                      color: snackCardColor,
                      onAddPressed:
                          // editDisabled ? null :
                          () => addCard(PointType.snack),
                      cardKey: cardKeySnack,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fitpoints',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 15),
                  children: [
                    Row(
                        children: diary.activities!
                            .map((e) => ActivityCard(
                                cardKey: GlobalKey<FlipCardState>(),
                                color: activityCardColor,
                                icon: IconData(e.icon!.codePoint,
                                    fontFamily: e.icon!.fontFamily,
                                    fontPackage: e.icon!.fontPackage,
                                    matchTextDirection:
                                        e.icon!.matchTextDirection),
                                title: e.title!,
                                points: diary.fitpoints!
                                    .firstWhere(
                                        (element) => element.activityId == e.id)
                                    .points!,
                                addField: false,
                                onAddPressed: () {},
                                onRemovePressed:
                                    //  editDisabled
                                    //     ? null
                                    //     :
                                    () => removePressed(e)))
                            .toList()),
                    ActivityCard(
                        cardKey: GlobalKey<FlipCardState>(),
                        color: activityAddCardColor,
                        icon: CommunityMaterialIcons.google_fit,
                        title: 'Aktivität',
                        points: 0,
                        addField: true,
                        onAddPressed:
                            // editDisabled
                            //     ? null
                            //     :
                            () {
                          if (diary.id == 'null') {
                            Diary newDiary = Diary(
                                id: const Uuid().v1(),
                                date: initDate,
                                dailyRestPoints:
                                    AllData.profiledata.dailyPoints,
                                actualPointSafe: AllData.profiledata.pointSafe,
                                breakfast: [],
                                lunch: [],
                                dinner: [],
                                snack: [],
                                fitpoints: [],
                                activities: []);
                            AllData.diaries.add(newDiary);
                            DBHelper.insert('Diary', newDiary.toMap());
                            diary = newDiary;
                          }
                          Navigator.of(context)
                              .pushNamed(Activities.routeName,
                                  arguments: diary.id)
                              .then((value) => setState(() {}));
                        },
                        // onAddActivityPressed(),
                        onRemovePressed: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15)
      ],
    );
  }

  void onDateSelected(DateTime? date) {
    bool hasDay = false;
    for (var element in AllData.diaries) {
      if (date != null &&
          element.date!.year == date.year &&
          element.date!.month == date.month &&
          element.date!.day == date.day) {
        hasDay = true;
        diary = element;
      }
    }
    if (!hasDay) {
      diary = Diary(
          id: 'null',
          date: date!,
          dailyRestPoints: AllData.profiledata.dailyPoints,
          actualPointSafe: AllData.profiledata.pointSafe,
          breakfast: [],
          lunch: [],
          dinner: [],
          activities: [],
          fitpoints: [],
          snack: []);
    }

    setState(() {
      initDate = date!;
    });
  }

  void onEditPressed(
      int val, DateTime date, BuildContext context, Diary diary) {
    if (diary.id == 'null') {
      Diary newDiary = Diary(
          id: const Uuid().v1(),
          date: date,
          dailyRestPoints: AllData.profiledata.dailyPoints,
          actualPointSafe: AllData.profiledata.pointSafe,
          breakfast: [],
          lunch: [],
          dinner: [],
          snack: [],
          fitpoints: [],
          activities: []);
      AllData.diaries.add(newDiary);
      DBHelper.insert('Diary', newDiary.toMap());
      diary = newDiary;
    }
    Navigator.of(context).pushNamed(EditDiary.routeName,
        arguments: [date, diary.id]).then((value) {
      onDateSelected(date);
      setState(() {});
    });
  }

  addCard(PointType type) {
    if (diary.id == 'null') {
      Diary newDiary = Diary(
          id: const Uuid().v1(),
          date: initDate,
          dailyRestPoints: AllData.profiledata.dailyPoints,
          actualPointSafe: AllData.profiledata.pointSafe,
          breakfast: [],
          lunch: [],
          dinner: [],
          snack: [],
          fitpoints: [],
          activities: []);
      AllData.diaries.add(newDiary);
      DBHelper.insert('Diary', newDiary.toMap());
      diary = newDiary;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodSheet(
          type: type,
          diaryId: diary.id!,
          onPressed: () async {
            Navigator.of(context).pop();
            setState(() {
              if (type == PointType.breakfast) {
                cardKeyBreakfast.currentState!.toggleCard();
              } else if (type == PointType.lunch) {
                cardKeyLunch.currentState!.toggleCard();
              } else if (type == PointType.dinner) {
                cardKeyDinner.currentState!.toggleCard();
              } else if (type == PointType.snack) {
                cardKeySnack.currentState!.toggleCard();
              }
            });
          }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }

  onAddActivityPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodSheet(
          type: PointType.activity,
          diaryId: diary.id!,
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

  undoDelete(Activity obj, dynamic removed) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Gelöscht'),
        action: SnackBarAction(
          label: 'Rückgängig',
          onPressed: () async {
            removed as FitPoint;
            AllData.fitpoints.add(removed);
            await DBHelper.insert('Fitpoint', removed.toMap());
            AllData.diaries
                .firstWhere((element) => element.id == diary.id)
                .activities!
                .add(obj);

            await calcDailyRestPoints(
                add: false,
                diaryId: diary.id!,
                points: diary.fitpoints!
                    .firstWhere((element) => element.activityId == obj.id)
                    .points!);

            setState(() {});
          },
        )));
  }

  removePressed(Activity obj) async {
    FitPoint removed;
    String id = '';
    id = AllData.fitpoints
        .firstWhere((element) =>
            element.activityId == obj.id && element.diaryId == diary.id)
        .id!;
    removed = AllData.fitpoints.firstWhere((element) => element.id == id);
    AllData.fitpoints.remove(removed);
    await DBHelper.delete('Fitpoint', where: 'ID = "$id"');
    AllData.diaries
        .firstWhere((element) => element.id == diary.id)
        .activities!
        .remove(obj);

    await calcDailyRestPoints(
        add: true,
        diaryId: diary.id!,
        points: diary.fitpoints!
            .firstWhere((element) => element.activityId == obj.id)
            .points!);

    setState(() {});

    undoDelete(obj, removed);
  }
}
