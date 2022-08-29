import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/enums.dart';
import 'package:punkte_zaehler/models/weigh.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
import 'package:punkte_zaehler/widgets/custom_linechart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class Scale extends StatefulWidget {
  const Scale({Key? key}) : super(key: key);

  @override
  State<Scale> createState() => _ScaleState();
}

class _ScaleState extends State<Scale> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  TextEditingController weightController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllData.weighs.sort((obj, obj2) => obj2.date!.compareTo(obj.date!));

    return ListView(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Grafik',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      const SizedBox(
        height: 250,
        child: CustomLineChart(),
      ),
      const Divider(
        indent: 15,
        endIndent: 15,
        thickness: 2,
        color: Colors.black,
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Wiegedaten',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      Form(
        key: _formKey,
        child: Column(
          children: [
            ListTile(
              title: const Text('Datum:'),
              trailing: GestureDetector(
                child: Text(dateFormat(date)),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 2000)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 1000)))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        date = value;
                      });
                    }
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Gewicht:'),
              trailing: SizedBox(
                width: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if ((value == null || value.isEmpty || value == '')) {
                            return '*';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
                        ],
                        controller: weightController,
                      ),
                    ),
                    const Text(' kg'),
                  ],
                ),
              ),
            ),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      // Theme.of(context).primaryColor.withOpacity(0.5)),
                      Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
              onPressed: () => addData(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Daten hinzufügen'),
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              thickness: 2,
              color: Colors.black,
            ),
            ExpansionTile(
              title: const Text(
                'Liste aller Daten',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              children: AllData.weighs
                  .map((e) => ListTile(
                        title: Text(dateFormat(e.date!)),
                        trailing: Text('${decimalFormat(e.weight!)} kg'),
                      ))
                  .toList(),
            )
          ],
        ),
      )
    ]);
  }

  addData() {
    if (_formKey.currentState!.validate()) {
      Weigh weigh = Weigh(
          id: const Uuid().v1(),
          date: date,
          weight: doubleCommaToPoint(weightController.text));
      AllData.weighs.add(weigh);
      AllData.profiledata.currentWeight!.weight =
          doubleCommaToPoint(weightController.text);
      AllData.profiledata.currentWeight!.weight =
          doubleCommaToPoint(weightController.text);
      AllData.profiledata.currentWeight!.date = DateTime.now();
      if (AllData.prefs.getInt('deletePointsafeDay') ==
          PointSafeDelete.withWeigh.index) {
        AllData.profiledata.pointSafe = 0;
        AllData.profiledata.pointSafeDate = DateTime.now();
      }

      if (AllData.prefs.getBool('autoDailypointChange')!) {
        double newDaily = calculateDailypoints(
            gender: AllData.profiledata.gender!.index,
            weight: doubleCommaToPoint(weightController.text),
            height: AllData.profiledata.height!,
            move: AllData.profiledata.movement!.index,
            purpose: AllData.profiledata.goal!.index,
            age: AllData.profiledata.age!);

        if (newDaily != AllData.profiledata.dailyPoints) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            content: Text(
              'Tagespunkte geändert:   ${decimalFormat(AllData.profiledata.dailyPoints!)} ➟ ${decimalFormat(newDaily)} ',
              textAlign: TextAlign.center,
            ),
          ));
          AllData.profiledata.dailyPoints = newDaily;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            content: Text(
              'Hinzugefügt',
              textAlign: TextAlign.center,
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text(
            'Hinzugefügt',
            textAlign: TextAlign.center,
          ),
        ));
      }

      weightController.text = '';

      DBHelper.update('Profiledata', AllData.profiledata.toMap());
      DBHelper.insert('Weigh', weigh.toMap());
      setState(() {});
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
