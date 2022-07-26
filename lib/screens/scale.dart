import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/models/all_data.dart';
import 'package:punkte_zaehler/models/weigh.dart';
import 'package:punkte_zaehler/services/db_helper.dart';
import 'package:punkte_zaehler/services/help_methods.dart';
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
  Widget build(BuildContext context) {
    AllData.weighs.sort((obj, obj2) => obj2.date!.compareTo(obj.date!));

    return ListView(children: [
      const Text('Here is someday the chart :D'),
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

      DBHelper.update('Profiledata', AllData.profiledata.toMap());
      DBHelper.insert('Weigh', weigh.toMap());
      setState(() {});
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
