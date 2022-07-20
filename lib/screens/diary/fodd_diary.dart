import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/screens/diary/edit_diary.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/diary/activity_card.dart';
import 'package:punkte_zaehler/widgets/diary/add_food_activity_sheet.dart';
import 'package:punkte_zaehler/widgets/diary/diary_card.dart';
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
      breakfast: [],
      lunch: [],
      dinner: [],
      fitpoints: [],
      snack: []);
  DateTime initDate = DateTime.now();
  GlobalKey<FlipCardState> cardKeyBreakfast = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeyLunch = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeyDinner = GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeySnack = GlobalKey<FlipCardState>();

  @override
  void initState() {
    onDateSelected(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
          initialDate: initDate,
          firstDate: DateTime(2022, 1, 1),
          lastDate: DateTime(2022, 12, 31),
          onDateSelected: (date) => onDateSelected(date),
          leftMargin: 20,
          dayColor: const Color.fromARGB(255, 207, 107, 100),
          activeDayColor: const Color.fromARGB(255, 238, 178, 178),
          activeBackgroundDayColor: const Color.fromARGB(255, 107, 16, 7),
          dotsColor: const Color.fromARGB(255, 58, 66, 82),
          selectableDayPredicate: (date) => date.day != 23,
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
                      'Heute übrig:\n${decimalFormat(diary.dailyRestPoints!)} Punkte')),
              const Expanded(
                child: Text('Punktetresor:\n2 Punkte'),
              )
            ],
          ),
        ),
        const Divider(
            thickness: 2, color: Colors.black, indent: 10, endIndent: 10),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Essen',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () => onEditPressed(0, initDate, context, diary),
                    child: Row(
                      children: const [
                        Text('Bearbeiten',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                        Icon(Icons.arrow_right_alt_outlined)
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    FoodCard(
                      diary: diary,
                      type: PointType.breakfast,
                      title: 'Frühstück',
                      icon: CommunityMaterialIcons.coffee,
                      food: diary.breakfast!,
                      color: HexColor('#A60505').withOpacity(0.4),
                      onAddPressed: () => addCard(PointType.breakfast),
                      cardKey: cardKeyBreakfast,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.lunch,
                      title: 'Mittag',
                      icon: CommunityMaterialIcons.baguette,
                      food: diary.lunch!,
                      color: HexColor('#591D1D').withOpacity(0.5),
                      onAddPressed: () => addCard(PointType.lunch),
                      cardKey: cardKeyLunch,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.dinner,
                      title: 'Abend',
                      icon: CommunityMaterialIcons.pasta,
                      food: diary.dinner!,
                      color: HexColor('#D90707').withOpacity(0.5),
                      onAddPressed: () => addCard(PointType.dinner),
                      cardKey: cardKeyDinner,
                    ),
                    const SizedBox(width: 10),
                    FoodCard(
                      diary: diary,
                      type: PointType.snack,
                      title: 'Snack',
                      icon: CommunityMaterialIcons.cake_layered,
                      food: diary.snack!,
                      color: HexColor('##EE4F4F').withOpacity(0.2),
                      onAddPressed: () => addCard(PointType.snack),
                      cardKey: cardKeySnack,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Fitpoints',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Row(
                        children: diary.fitpoints!
                            .map((e) => ActivityCard(
                                cardKey: GlobalKey<FlipCardState>(),
                                color: HexColor('#A60505').withOpacity(0.4),
                                icon: CommunityMaterialIcons.dance_ballroom,
                                title: e.title!,
                                points: e.points!,
                                addField: false,
                                onAddPressed: () {},
                                onRemovePressed: () => removePressed(e)))
                            .toList()),
                    ActivityCard(
                        cardKey: GlobalKey<FlipCardState>(),
                        color: HexColor('#591D1D').withOpacity(0.5),
                        icon: CommunityMaterialIcons.google_fit,
                        title: 'Aktivität',
                        points: 0,
                        addField: true,
                        onAddPressed: () => onAddActivityPressed(),
                        onRemovePressed: () {})
                  ],
                ),
              ),
              // const SizedBox(height: 20),
              // Container(
              //   color: Colors.green,
              //   height: 200,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              // DiaryCard(
              //   title: 'Frühstück',
              //   onPressed: () => onEditPressed(0, initDate, context, diary),
              //   icon: Icons.free_breakfast_rounded,
              //   food: diary.breakfast!,
              //   activity: const [],
              //   isFood: true,
              // ),
              // DiaryCard(
              //   title: 'Mittag',
              //   onPressed: () => onEditPressed(1, initDate, context, diary),
              //   icon: Icons.lunch_dining,
              //   food: diary.lunch!,
              //   activity: const [],
              //   isFood: true,
              // ),
              // DiaryCard(
              //   title: 'Abend',
              //   onPressed: () => onEditPressed(2, initDate, context, diary),
              //   icon: Icons.dinner_dining,
              //   food: diary.dinner!,
              //   activity: const [],
              //   isFood: true,
              // ),
              // DiaryCard(
              //   title: 'Snacks',
              //   onPressed: () => onEditPressed(3, initDate, context, diary),
              //   icon: Icons.cake,
              //   food: diary.snack!,
              //   activity: const [],
              //   isFood: true,
              // ),
              // DiaryCard(
              //   title: 'Fitpoints',
              //   onPressed: () => onEditPressed(4, initDate, context, diary),
              //   icon: Icons.sports_gymnastics,
              //   food: const [],
              //   activity: diary.fitpoints!,
              //   isFood: false,
              // ),
              // ],
              // ),
              // ),
            ],
          ),
        )),
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
          breakfast: [],
          lunch: [],
          dinner: [],
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
          breakfast: [],
          lunch: [],
          dinner: [],
          snack: [],
          fitpoints: []);
      AllData.diaries.add(newDiary);
      DBHelper.insert('Diary', newDiary.toMap());
      diary = newDiary;
    }
    Navigator.of(context).pushNamed(EditDiary.routeName,
        arguments: [date, diary.id]).then((value) {
      onDateSelected(date);
      setState(() {});
    });
    // switch (val) {
    //   case 0:
    //     Navigator.of(context).pushNamed(EditDiary.routeName,
    //         arguments: [0, date, diary.id]).then((value) {
    //       onDateSelected(date);
    //       setState(() {});
    //     });
    //     break;
    //   case 1:
    //     Navigator.of(context).pushNamed(EditDiary.routeName,
    //         arguments: [1, date, diary.id]).then((value) {
    //       setState(() {});
    //     });
    //     break;
    //   case 2:
    //     Navigator.of(context).pushNamed(EditDiary.routeName,
    //         arguments: [2, date, diary.id]).then((value) {
    //       setState(() {});
    //     });
    //     break;
    //   case 3:
    //     Navigator.of(context).pushNamed(EditDiary.routeName,
    //         arguments: [3, date, diary.id]).then((value) {
    //       setState(() {});
    //     });
    //     break;
    //   case 4:
    //     Navigator.of(context).pushNamed(EditDiary.routeName,
    //         arguments: [4, date, diary.id]).then((value) {
    //       setState(() {});
    //     });
    //     break;
    //   default:
    //     break;
    // }
  }

  addCard(PointType type) {
    if (diary.id == 'null') {
      Diary newDiary = Diary(
          id: const Uuid().v1(),
          date: initDate,
          dailyRestPoints: AllData.profiledata.dailyPoints,
          breakfast: [],
          lunch: [],
          dinner: [],
          snack: [],
          fitpoints: []);
      AllData.diaries.add(newDiary);
      DBHelper.insert('Diary', newDiary.toMap());
      diary = newDiary;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => AddFoodActivitySheet(
          type: type,
          diaryId: diary.id!,
          onPressed: () async {
            Navigator.of(context).pop();
            // getData();
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
      builder: (ctx) => AddFoodActivitySheet(
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
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar
      ..showSnackBar(SnackBar(
          content: const Text('Gelöscht'),
          action: SnackBarAction(
            label: 'Rückgängig',
            onPressed: () async {
              removed as FitPoint;
              AllData.fitpoints.add(removed);
              await DBHelper.insert('Fitpoint', removed.toMap());
              AllData.diaries
                  .firstWhere((element) => element.id == diary.id)
                  .fitpoints!
                  .add(obj);

              await calcDialyRestPoints(obj, true);
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
        .fitpoints!
        .remove(obj);

    await calcDialyRestPoints(obj, false);
    setState(() {});

    undoDelete(obj, removed);
  }

  Future<void> calcDialyRestPoints(Activity obj, bool add) async {
    if (!add) {
      AllData.diaries
          .firstWhere((element) => element.id == diary.id)
          .dailyRestPoints = AllData.diaries
              .firstWhere((element) => element.id == diary.id)
              .dailyRestPoints! +
          obj.points!;
    } else {
      AllData.diaries
          .firstWhere((element) => element.id == diary.id)
          .dailyRestPoints = AllData.diaries
              .firstWhere((element) => element.id == diary.id)
              .dailyRestPoints! -
          obj.points!;
    }

    await DBHelper.update('Diary',
        AllData.diaries.firstWhere((element) => element.id == diary.id).toMap(),
        where: 'ID = "${diary.id}"');
  }
}



// import 'package:flutter/material.dart';
// import 'package:punkte_zaehler/widgets/meals_list_view.dart';

// class FoodDiary extends StatefulWidget {
//   const FoodDiary({Key? key, this.animationController}) : super(key: key);

//   final AnimationController? animationController;
//   @override
//   _MyDiaryScreenState createState() => _MyDiaryScreenState();
// }

// class _MyDiaryScreenState extends State<FoodDiary>
//     with TickerProviderStateMixin {
//   Animation<double>? topBarAnimation;

//   List<Widget> listViews = <Widget>[];
//   final ScrollController scrollController = ScrollController();
//   double topBarOpacity = 0.0;
//   AnimationController? animationController;

//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);
//     topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//             parent: animationController!,
//             curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
//     addAllListData();

//     scrollController.addListener(() {
//       if (scrollController.offset >= 24) {
//         if (topBarOpacity != 1.0) {
//           setState(() {
//             topBarOpacity = 1.0;
//           });
//         }
//       } else if (scrollController.offset <= 24 &&
//           scrollController.offset >= 0) {
//         if (topBarOpacity != scrollController.offset / 24) {
//           setState(() {
//             topBarOpacity = scrollController.offset / 24;
//           });
//         }
//       } else if (scrollController.offset <= 0) {
//         if (topBarOpacity != 0.0) {
//           setState(() {
//             topBarOpacity = 0.0;
//           });
//         }
//       }
//     });
//     super.initState();
//   }

//   void addAllListData() {
//     const int count = 9;

//     listViews.add(
//       MealsListView(
//         mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
//             CurvedAnimation(
//                 parent: animationController!,
//                 curve: Interval((1 / count) * 3, 1.0,
//                     curve: Curves.fastOutSlowIn))),
//         mainScreenAnimationController: animationController,
//       ),
//     );
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 50));
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: FitnessAppTheme.background,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: <Widget>[
//             getMainListViewUI(),
//             getAppBarUI(),
//             SizedBox(
//               height: MediaQuery.of(context).padding.bottom,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget getMainListViewUI() {
//     return FutureBuilder<bool>(
//       future: getData(),
//       builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         } else {
//           return ListView.builder(
//             controller: scrollController,
//             padding: EdgeInsets.only(
//               top: AppBar().preferredSize.height +
//                   MediaQuery.of(context).padding.top +
//                   24,
//               bottom: 62 + MediaQuery.of(context).padding.bottom,
//             ),
//             itemCount: listViews.length,
//             scrollDirection: Axis.vertical,
//             itemBuilder: (BuildContext context, int index) {
//               animationController?.forward();
//               return listViews[index];
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget getAppBarUI() {
//     return Column(
//       children: <Widget>[
//         AnimatedBuilder(
//           animation: animationController!,
//           builder: (BuildContext context, Widget? child) {
//             return FadeTransition(
//               opacity: topBarAnimation!,
//               child: Transform(
//                 transform: Matrix4.translationValues(
//                     0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     // color: FitnessAppTheme.white.withOpacity(topBarOpacity),
//                     borderRadius: const BorderRadius.only(
//                       bottomLeft: Radius.circular(32.0),
//                     ),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                           // color: FitnessAppTheme.grey
//                           //     .withOpacity(0.4 * topBarOpacity),
//                           offset: const Offset(1.1, 1.1),
//                           blurRadius: 10.0),
//                     ],
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: MediaQuery.of(context).padding.top,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                             left: 16,
//                             right: 16,
//                             top: 16 - 8.0 * topBarOpacity,
//                             bottom: 12 - 8.0 * topBarOpacity),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'My Diary',
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     // fontFamily: FitnessAppTheme.fontName,
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 22 + 6 - 6 * topBarOpacity,
//                                     letterSpacing: 1.2,
//                                     // color: FitnessAppTheme.darkerText,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 38,
//                               width: 38,
//                               child: InkWell(
//                                 highlightColor: Colors.transparent,
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(32.0)),
//                                 onTap: () {},
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.keyboard_arrow_left,
//                                     // color: FitnessAppTheme.grey,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 8,
//                                 right: 8,
//                               ),
//                               child: Row(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 8),
//                                     child: Icon(
//                                       Icons.calendar_today,
//                                       // color: FitnessAppTheme.grey,
//                                       size: 18,
//                                     ),
//                                   ),
//                                   Text(
//                                     '15 May',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       // fontFamily: FitnessAppTheme.fontName,
//                                       fontWeight: FontWeight.normal,
//                                       fontSize: 18,
//                                       letterSpacing: -0.2,
//                                       // color: FitnessAppTheme.darkerText,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 38,
//                               width: 38,
//                               child: InkWell(
//                                 highlightColor: Colors.transparent,
//                                 borderRadius: const BorderRadius.all(
//                                     Radius.circular(32.0)),
//                                 onTap: () {},
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.keyboard_arrow_right,
//                                     // color: FitnessAppTheme.grey,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
