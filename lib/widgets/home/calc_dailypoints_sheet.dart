import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/diary.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class CalcDailypointsSheet extends StatefulWidget {
  final BuildContext ctx;
  final Function onPressed;
  const CalcDailypointsSheet(
      {Key? key, required this.ctx, required this.onPressed})
      : super(key: key);

  @override
  State<CalcDailypointsSheet> createState() => _CalcDailypointsSheetState();
}

class _CalcDailypointsSheetState extends State<CalcDailypointsSheet> {
  TextEditingController ageController =
      TextEditingController(text: '${AllData.profiledata.age ?? ''}');
  TextEditingController weightController = TextEditingController(
      text: '${AllData.profiledata.currentWeight!.weight ?? ''}');
  TextEditingController heightController =
      TextEditingController(text: '${AllData.profiledata.height ?? ''}');
  int genderValue = AllData.profiledata.gender!.index;
  int moveDropdown = AllData.profiledata.movement!.index;
  int purposeDropdown = AllData.profiledata.goal!.index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(widget.ctx).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 0,
                        groupValue: genderValue,
                        onChanged: (val) {
                          setState(() {
                            genderValue = val as int;
                          });
                        },
                      ),
                      GestureDetector(
                        child: const Text('Männlich'),
                        onTap: () {
                          setState(() {
                            genderValue = 0;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 1,
                        groupValue: genderValue,
                        onChanged: (val) {
                          setState(() {
                            genderValue = val as int;
                          });
                        },
                      ),
                      GestureDetector(
                        child: const Text('Weiblich'),
                        onTap: () {
                          setState(() {
                            genderValue = 1;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              CustomTextField(
                onChanged: null,
                controller: ageController,
                mandatory: false,
                labelText: 'Alter',
                hintText: '',
              ),
              CustomTextField(
                onChanged: null,
                controller: weightController,
                mandatory: false,
                labelText: 'Gewicht',
                hintText: 'in kg',
              ),
              CustomTextField(
                onChanged: null,
                controller: heightController,
                mandatory: false,
                labelText: 'Größe',
                hintText: 'in mm',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bewegung'),
                  DropdownButton(
                      value: moveDropdown,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text('Keine Bewegung'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Etwas Bewegung'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Viel Bewegung'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text('Täglich viel Bewegung'),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          moveDropdown = val as int;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ziel'),
                  DropdownButton(
                      value: purposeDropdown,
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text('Gewicht halten'),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Gewicht senken'),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() {
                          purposeDropdown = val as int;
                        });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Abbrechen')),
                  OutlinedButton(
                      onPressed: () async {
                        AllData.profiledata.dailyPoints = calculateDailypoints(
                          gender: genderValue,
                          age: int.parse(ageController.text),
                          weight: double.parse(weightController.text),
                          height: double.parse(heightController.text),
                          move: moveDropdown,
                          purpose: purposeDropdown,
                        );
                        AllData.profiledata.gender = Gender.values[genderValue];
                        AllData.profiledata.age = int.parse(ageController.text);
                        AllData.profiledata.height =
                            double.parse(heightController.text);
                        AllData.profiledata.movement =
                            Movement.values[moveDropdown];
                        AllData.profiledata.goal = Goal.values[purposeDropdown];
                        await DBHelper.update(
                                'Profiledata', AllData.profiledata.toMap())
                            .then((value) => Navigator.pop(context));

                        calcTodayDiaryRestPoints();
                        widget.onPressed();
                      },
                      child: const Text('Übernehmen')),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void calcTodayDiaryRestPoints() {
    Diary? d;
    d = AllData.diaries.firstWhere(
        (element) => Jiffy(element.date).isSame(DateTime.now(), Units.DAY),
        orElse: () => Diary(
            id: 'NULL',
            date: null,
            dailyRestPoints: null,
            breakfast: null,
            lunch: null,
            dinner: null,
            snack: null,
            fitpoints: null));
    if (d.id != 'NULL') {
      double restpoints = AllData.profiledata.dailyPoints!;
      for (var element in d.breakfast!) {
        restpoints -= element.points!;
      }
      for (var element in d.lunch!) {
        restpoints -= element.points!;
      }
      for (var element in d.dinner!) {
        restpoints -= element.points!;
      }
      for (var element in d.snack!) {
        restpoints -= element.points!;
      }
      for (var element in d.fitpoints!) {
        restpoints += element.points!;
      }
      AllData.diaries
          .firstWhere((element) =>
              Jiffy(element.date).isSame(DateTime.now(), Units.DAY))
          .dailyRestPoints = restpoints;
      DBHelper.update(
          'Diary',
          AllData.diaries
              .firstWhere((element) =>
                  Jiffy(element.date).isSame(DateTime.now(), Units.DAY))
              .toMap(),
          where:
              'ID = "${AllData.diaries.firstWhere((element) => Jiffy(element.date).isSame(DateTime.now(), Units.DAY)).id}"');
    }
  }
}
