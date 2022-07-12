import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/screens/diary/edit_diary.dart';
import 'package:punkte_zaehler/widgets/diary_card.dart';

class FoodDiary extends StatefulWidget {
  const FoodDiary({Key? key}) : super(key: key);

  @override
  State<FoodDiary> createState() => _FoodDiaryState();
}

class _FoodDiaryState extends State<FoodDiary> {
  Diary diary = Diary(
      id: 'null',
      date: DateTime.now(),
      dailyRestPoints: 22,
      breakfast: [],
      lunch: [],
      dinner: [],
      fitpoints: [],
      snack: []);
  DateTime initDate = DateTime.now();

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
          // monthColor: Colors.,
          dayColor: const Color.fromARGB(255, 207, 107, 100),
          activeDayColor: const Color.fromARGB(255, 238, 178, 178),
          activeBackgroundDayColor: const Color.fromARGB(255, 107, 16, 7),
          dotsColor: const Color.fromARGB(255, 58, 66, 82),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'de',
        ),
        const Divider(),
        Expanded(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('5 Punkte heute übrig'),
                  Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.vault),
                      Text('   Punktetresor: 2')
                    ],
                  )
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     Opacity(
                  //         opacity: 0.3,
                  //         child: FaIcon(FontAwesomeIcons.vault, size: 40)),
                  //     Text(
                  //       '2',
                  //       style: TextStyle(
                  //           fontSize: 40,
                  //           fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
            // Column(
            //   children: const [
            //     ListTile(
            //         leading: Icon(Icons.pie_chart_outline_outlined),
            //         title: Text('Übrige Punkte:'),
            //         trailing: Text('5')),
            //     ListTile(title: Text('im PunkteTresor'))
            //   ],
            // ),
            const Divider(),
            const SizedBox(height: 20),
            // Container(
            //   color: Colors.green,
            //   height: 200,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            DiaryCard(
              title: 'Frühstück',
              onPressed: () => onEditPressed(0, initDate, context),
              icon: Icons.free_breakfast_rounded,
              food: diary.breakfast!,
              activity: const [],
              isFood: true,
            ),
            DiaryCard(
              title: 'Mittag',
              onPressed: () => onEditPressed(1, initDate, context),
              icon: Icons.lunch_dining,
              food: diary.lunch!,
              activity: const [],
              isFood: true,
            ),
            DiaryCard(
              title: 'Abend',
              onPressed: () => onEditPressed(2, initDate, context),
              icon: Icons.dinner_dining,
              food: diary.dinner!,
              activity: const [],
              isFood: true,
            ),
            DiaryCard(
              title: 'Snacks',
              onPressed: () => onEditPressed(3, initDate, context),
              icon: Icons.cake,
              food: diary.dinner!,
              activity: const [],
              isFood: true,
            ),
            DiaryCard(
              title: 'Fitpoints',
              onPressed: () => onEditPressed(4, initDate, context),
              icon: Icons.sports_gymnastics,
              food: const [],
              activity: diary.fitpoints!,
              isFood: true,
            ),
            // ],
            // ),
            // ),
          ],
        )),
        const SizedBox(height: 15)
      ],
    );
  }

  void onDateSelected(DateTime? date) {
    bool hasDay = false;
    Diary.getDummyData().forEach((element) {
      if (date != null &&
          element.date!.year == date.year &&
          element.date!.month == date.month &&
          element.date!.day == date.day) {
        hasDay = true;
        diary = element;
      }
    });
    if (!hasDay) {
      diary = Diary(
          id: 'null',
          date: date!,
          dailyRestPoints: 22,
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
}

void onEditPressed(int val, DateTime date, BuildContext context) {
  switch (val) {
    case 0:
      Navigator.of(context)
          .pushNamed(EditDiary.routeName, arguments: ['breakfast', date]);
      break;
    case 1:
      Navigator.of(context)
          .pushNamed(EditDiary.routeName, arguments: ['lunch', date]);
      break;
    case 2:
      Navigator.of(context)
          .pushNamed(EditDiary.routeName, arguments: ['dinner', date]);
      break;
    case 3:
      Navigator.of(context)
          .pushNamed(EditDiary.routeName, arguments: ['snacks', date]);
      break;
    case 4:
      Navigator.of(context)
          .pushNamed(EditDiary.routeName, arguments: ['activity', date]);
      break;
    default:
      break;
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
