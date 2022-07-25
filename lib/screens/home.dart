import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/home/calc_dailypoints_sheet.dart';
import 'package:punkte_zaehler/widgets/home/home_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ProfileData profileData = ProfileData.getDummyData();
  TextEditingController startController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController currentController = TextEditingController();

  @override
  void initState() {
    startController.text = AllData.profiledata.startWeight!.weight == null
        ? ''
        : decimalFormat(AllData.profiledata.startWeight!.weight!);
    targetController.text = AllData.profiledata.targetWeight!.weight == null
        ? ''
        : decimalFormat(AllData.profiledata.targetWeight!.weight!);
    currentController.text = AllData.profiledata.currentWeight!.weight == null
        ? ''
        : decimalFormat(AllData.profiledata.currentWeight!.weight!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // DateTime other = DateTime(2022,07,20);

    // print(now);
    // print(other);

    // print(Jiffy(other).isBefore(now, Units.DAY));

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Stack(
        children: [
          Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(300, 200),
                    bottomRight: Radius.elliptical(190, 60)),
                color: Theme.of(context).primaryColor,
              ),
              // color: Theme.of(context).primaryColor,
              width: double.infinity,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Icon(
                      Icons.account_circle_rounded,
                      size: 80,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AllData.profiledata.name ?? '',
                        // 'NAME',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        AllData.profiledata.email ?? '',
                        // '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${decimalFormat(AllData.profiledata.dailyPoints!)} Tagespunkte',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  HomeCard(
                      date: AllData.profiledata.startWeight!.date!,
                      onDateChanged: (val) => dateChanged(0, val),
                      onWeightChanged: () => weightChanged(0),
                      title: 'Startgewicht',
                      weightController: startController),
                  HomeCard(
                      date: AllData.profiledata.targetWeight!.date!,
                      onDateChanged: (val) => dateChanged(1, val),
                      onWeightChanged: () => weightChanged(1),
                      title: 'Zielgewicht',
                      weightController: targetController),
                  HomeCard(
                      date: AllData.profiledata.currentWeight!.date!,
                      onDateChanged: (val) => dateChanged(2, val),
                      onWeightChanged: () => weightChanged(2),
                      title: 'Aktuelles Gewicht',
                      weightController: currentController),
                  const SizedBox(height: 40),
                ],
              ),
            )
          ]),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          // Theme.of(context).primaryColor.withOpacity(0.5)),
                          Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    calcDailypointsPressed();
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Tagespunkte berechnen'),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void calcDailypointsPressed() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return CalcDailypointsSheet(
              ctx: context,
              onPressed: () {
                setState(() {});
              });
        });
  }

  dateChanged(int i, DateTime date) async {
    switch (i) {
      case 0: //Startweight
        AllData.profiledata.startWeight!.date = date;

        await DBHelper.update(
            'Weight', AllData.profiledata.startWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.startWeight!.id}"');
        break;
      case 1: //Targetweight
        AllData.profiledata.targetWeight!.date = date;

        await DBHelper.update(
            'Weight', AllData.profiledata.targetWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.targetWeight!.id}"');
        break;
      case 2: //Currentweight
        AllData.profiledata.currentWeight!.date = date;

        await DBHelper.update(
            'Weight', AllData.profiledata.currentWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.currentWeight!.id}"');
        break;
      default:
    }

    setState(() {});
  }

  weightChanged(int i) async {
    switch (i) {
      case 0: //Startweight
        AllData.profiledata.startWeight!.weight = startController.text == ''
            ? null
            : doubleCommaToPoint(startController.text);
        await DBHelper.update(
            'Weight', AllData.profiledata.startWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.startWeight!.id}"');
        break;
      case 1: //Targetweight
        AllData.profiledata.targetWeight!.weight = targetController.text == ''
            ? null
            : doubleCommaToPoint(targetController.text);

        await DBHelper.update(
            'Weight', AllData.profiledata.targetWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.targetWeight!.id}"');
        break;
      case 2: //Currentweight
        AllData.profiledata.currentWeight!.weight = currentController.text == ''
            ? null
            : doubleCommaToPoint(currentController.text);

        await DBHelper.update(
            'Weight', AllData.profiledata.currentWeight!.toMap(),
            where: 'ID = "${AllData.profiledata.currentWeight!.id}"');
        break;
      default:
    }

    // setState(() {
    //   startController.text = '${AllData.profiledata.startWeight!.weight}';
    //   targetController.text = '${AllData.profiledata.targetWeight!.weight}';
    //   currentController.text = '${AllData.profiledata.currentWeight!.weight}';
    // });
  }

  // void editWeightsPressed() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return EditWeightsSheet(
  //             ctx: context,
  //             onPressed: () {
  //               setState(() {});
  //             });
  //       });
  // }
}
