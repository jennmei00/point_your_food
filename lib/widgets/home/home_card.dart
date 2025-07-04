import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:punkte_zaehler/services/help_methods.dart';

class HomeCard extends StatelessWidget {
  final DateTime date;
  // final double weight;
  final String title;
  final Function onDateChanged;
  final Function onWeightChanged;
  final TextEditingController weightController;
  const HomeCard(
      {super.key,
      required this.date,
      // required this.weight,
      required this.onDateChanged,
      required this.onWeightChanged,
      required this.title,
      required this.weightController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            elevation: 5,
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
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 1000)))
                          .then((value) => onDateChanged(value));
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
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(
                                  r'^(?:-?(?:[0-9]+))?(?:\,[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?')),
                            ],
                            controller: weightController,
                            onChanged: (val) => onWeightChanged(),
                          ),
                        ),
                        const Text(' kg'),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        const SizedBox(height: 15)
      ],
    );
  }
}
