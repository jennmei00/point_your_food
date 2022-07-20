import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class CalcDailypointsSheet extends StatefulWidget {
  final BuildContext ctx;
  final Function onPressed;
  const CalcDailypointsSheet({Key? key, required this.ctx, required this.onPressed}) : super(key: key);

  @override
  State<CalcDailypointsSheet> createState() => _CalcDailypointsSheetState();
}

class _CalcDailypointsSheetState extends State<CalcDailypointsSheet> {
  TextEditingController ageController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  int genderValue = 0;
  int moveDropdown = 0;
  int purposeDropdown = 0;

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
                hintText: 'in cm',
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
                          AllData.profiledata.dailyPoints =
                              calculateDailypoints(
                            gender: genderValue,
                            age: int.parse(ageController.text),
                            weight: double.parse(weightController.text),
                            height: double.parse(heightController.text),
                            move: moveDropdown,
                            purpose: purposeDropdown,
                          );
                        await DBHelper.update(
                                'Profiledata', AllData.profiledata.toMap())
                            .then((value) => Navigator.pop(context));
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
}
