import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/models/foods.dart';
import 'package:punkte_zaehler/screens/point_calculator.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';
import 'package:punkte_zaehler/widgets/diary/custom_type_ahead_form_field.dart';
import 'package:uuid/uuid.dart';

class AddFoodSheet extends StatefulWidget {
  final PointType type;
  final String diaryId;
  final Function onPressed;
  const AddFoodSheet({
    super.key,
    required this.type,
    required this.diaryId,
    required this.onPressed,
  });

  @override
  State<AddFoodSheet> createState() => _AddFoodSheetState();
}

class _AddFoodSheetState extends State<AddFoodSheet> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController pointController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CustomTypeAheadFormField(
            controller: nameController,
            labelText: 'Name',
            hintText: '',
            onSelected: (val) {
              nameController.text = val.title!;
              pointController.text = decimalFormat(val.points);
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  type: TextFieldType.decimal,
                  onChanged: null,
                  controller: pointController,
                  mandatory: true,
                  labelText: 'Punkte',
                  hintText: '',
                ),
              ),
              widget.type == PointType.activity
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: IconButton(
                        icon:
                            const FaIcon(FontAwesomeIcons.calculator, size: 40),
                        onPressed: () async {
                          dynamic foodPoints = await Navigator.of(context)
                              .pushNamed(PointCalculator.routeName,
                                  arguments: true);
                          setState(() {
                            pointController.text = foodPoints == null
                                ? ''
                                : decimalFormat(foodPoints);
                          });
                        },
                      ),
                    )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Abbrechen')),
              OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String foodId = '';
                      bool exists = false;
                      for (var element in AllData.foods) {
                        if (element.title == nameController.text &&
                            element.points ==
                                roundPoints(
                                    doubleCommaToPoint(pointController.text))) {
                          exists = true;
                          foodId = element.id!;
                        }
                      }

                      if (!exists) {
                        foodId = const Uuid().v1();
                        Food newFood = Food(
                            id: foodId,
                            title: nameController.text,
                            points: roundPoints(
                                doubleCommaToPoint(pointController.text)));
                        AllData.foods.add(newFood);
                        DBHelper.insert('Food', newFood.toMap());
                      }

                      if (widget.type != PointType.food) {
                        addFood(foodId);
                      }
                      // }

                      widget.onPressed();
                    }
                  },
                  child: const Text('Übernehmen')),
            ],
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }


  Future<void> addFood(String foodId) async {
    if (widget.type == PointType.breakfast) {
      Breakfast b = Breakfast(
          id: const Uuid().v1(), diaryId: widget.diaryId, foodId: foodId);
      DBHelper.insert('Breakfast', b.toMap());
      AllData.breakfast.add(b);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .breakfast!
          .add(AllData.foods.firstWhere((element) => element.id == foodId));
    } else if (widget.type == PointType.lunch) {
      Lunch l =
          Lunch(id: const Uuid().v1(), diaryId: widget.diaryId, foodId: foodId);
      DBHelper.insert('Lunch', l.toMap());
      AllData.lunch.add(l);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .lunch!
          .add(AllData.foods.firstWhere((element) => element.id == foodId));
    } else if (widget.type == PointType.dinner) {
      Dinner d = Dinner(
          id: const Uuid().v1(), diaryId: widget.diaryId, foodId: foodId);
      DBHelper.insert('Dinner', d.toMap());
      AllData.dinner.add(d);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .dinner!
          .add(AllData.foods.firstWhere((element) => element.id == foodId));
    } else if (widget.type == PointType.snack) {
      Snack s =
          Snack(id: const Uuid().v1(), diaryId: widget.diaryId, foodId: foodId);
      DBHelper.insert('Snack', s.toMap());
      AllData.snack.add(s);
      AllData.diaries
          .firstWhere((element) => element.id == widget.diaryId)
          .snack!
          .add(AllData.foods.firstWhere((element) => element.id == foodId));
    }

    await calcDailyRestPoints(
        add: true,
        diaryId: widget.diaryId,
        points: AllData.foods
            .firstWhere((element) => element.id == foodId)
            .points!);
  }
}
