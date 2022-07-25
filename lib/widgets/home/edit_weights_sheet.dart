import 'package:flutter/material.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class EditWeightsSheet extends StatefulWidget {
  final BuildContext ctx;
  final Function onPressed;
  const EditWeightsSheet({Key? key, required this.ctx, required this.onPressed})
      : super(key: key);

  @override
  State<EditWeightsSheet> createState() => _EditWeightsSheetState();
}

class _EditWeightsSheetState extends State<EditWeightsSheet> {
  TextEditingController startweightController = TextEditingController();
  TextEditingController targetweightController = TextEditingController();
  TextEditingController currentweightController = TextEditingController();
  DateTime startweightDate = DateTime.now();
  DateTime targetweightDate = DateTime.now();
  DateTime currentweightDate = DateTime.now();

  @override
  void initState() {
    startweightController = TextEditingController(
        text: AllData.profiledata.startWeight!.weight.toString());
    targetweightController = TextEditingController(
        text: AllData.profiledata.targetWeight!.weight.toString());
    currentweightController = TextEditingController(
        text: AllData.profiledata.currentWeight!.weight.toString());
    startweightDate = AllData.profiledata.startWeight!.date!;
    targetweightDate = AllData.profiledata.targetWeight!.date!;
    currentweightDate = AllData.profiledata.currentWeight!.date!;

    super.initState();
  }

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
                children: [
                  Column(
                    children: [
                      // const Text('Datum:'),
                      GestureDetector(
                        child: Text(
                          '${startweightDate.day}.${startweightDate.month}.${startweightDate.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => changeStartweightDate(),
                      ),
                      IconButton(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          onPressed: () => changeStartweightDate(),
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 40,
                          ))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      type: TextFieldType.decimal,
                      onChanged: null,
                      controller: startweightController,
                      mandatory: false,
                      labelText: 'Startgewicht',
                      hintText: 'in kg',
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      type: TextFieldType.decimal,
                      onChanged: null,
                      controller: targetweightController,
                      mandatory: false,
                      labelText: 'Zielgewicht',
                      hintText: 'in kg',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      GestureDetector(
                        child: Text(
                          '${targetweightDate.day}.${targetweightDate.month}.${targetweightDate.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => changeTargetweightDate(),
                      ),
                      IconButton(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          onPressed: () => changeTargetweightDate(),
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 40,
                          ))
                    ],
                  ),
                  // const SizedBox(width: 10),
                  // Expanded(
                  //   child: CustomTextField(
                  //     onChanged: null,
                  //     controller: targetweightController,
                  //     mandatory: false,
                  //     labelText: 'Zielgewicht',
                  //     hintText: 'in kg',
                  //   ),
                  // ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Text(
                          '${currentweightDate.day}.${currentweightDate.month}.${currentweightDate.year}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () => changeCurrentweightDate(),
                      ),
                      IconButton(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          onPressed: () => changeCurrentweightDate(),
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 40,
                          ))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      type: TextFieldType.decimal,
                      onChanged: null,
                      controller: currentweightController,
                      mandatory: false,
                      labelText: 'Aktuelles Gewicht',
                      hintText: 'in kg',
                    ),
                  ),
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
                        await updateWeights()
                            .then((value) => Navigator.of(context).pop());

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

  Future<void> updateWeights() async {
    AllData.weights.firstWhere((element) => element.id == '1234').date =
        startweightDate;
    AllData.weights.firstWhere((element) => element.id == '1234').weight =
        doubleCommaToPoint(startweightController.text);

    AllData.weights.firstWhere((element) => element.id == '2345').date =
        targetweightDate;
    AllData.weights.firstWhere((element) => element.id == '2345').weight =
        doubleCommaToPoint(targetweightController.text);

    AllData.weights.firstWhere((element) => element.id == '4567').date =
        currentweightDate;
    AllData.weights.firstWhere((element) => element.id == '4567').weight =
        doubleCommaToPoint(currentweightController.text);

    for (var element in AllData.weights) {
      await DBHelper.update('Weight', element.toMap(),
          where: 'ID = ${element.id}');
    }
  }

  changeStartweightDate() async {
    startweightDate = await showDatePicker(
        context: context,
        initialDate: startweightDate,
        firstDate: DateTime.now().subtract(const Duration(days: 1000)),
        lastDate: DateTime.now()) as DateTime;
    setState(() {});
  }

  changeTargetweightDate() async {
    targetweightDate = await showDatePicker(
        context: context,
        initialDate: targetweightDate,
        firstDate: DateTime.now().subtract(const Duration(days: 1000)),
        lastDate: DateTime.now().add(const Duration(days: 2000))) as DateTime;
    setState(() {});
  }

  changeCurrentweightDate() async {
    currentweightDate = await showDatePicker(
        context: context,
        initialDate: currentweightDate,
        firstDate: DateTime.now().subtract(const Duration(days: 1000)),
        lastDate: DateTime.now()) as DateTime;
    setState(() {});
  }
}
