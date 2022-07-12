import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:punkte_zaehler/models/activity.dart';
import 'package:punkte_zaehler/models/food.dart';
import 'package:punkte_zaehler/widgets/custom_textfield.dart';

class EditDiary extends StatefulWidget {
  const EditDiary({Key? key, required this.type, required this.date})
      : super(key: key);
  static const routeName = '/edit_diary';
  final String type;
  final DateTime date;

  @override
  State<EditDiary> createState() => _EditDiaryState();
}

class _EditDiaryState extends State<EditDiary> {
  List<Food> food = [];
  List<Activity> activity = [];

  @override
  void initState() {
    if (widget.type == 'breakfast') {
      // food =
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bearbeiten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Frühstück',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text('8 Punkte Gesamt'),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Pencake'), Text('1.5')],
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 216, 77, 67),
                        ),
                        onPressed: () => deleteCard()),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Pencake'), Text('1.5')],
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 216, 77, 67),
                        ),
                        onPressed: () => deleteCard()),
                  ),
                ),
                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Ei'), Text('1.0')],
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 216, 77, 67),
                        ),
                        onPressed: () => deleteCard()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    OutlinedButton(
                        onPressed: () => addCard(),
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            Text(' Hinzufügen')
                          ],
                        )),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  deleteCard() {}

  addCard() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          CustomTextField(
            onChanged: () {},
            controller: TextEditingController(),
            mandatory: false,
            labelText: 'Name',
            hintText: 'Pencake',
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  onChanged: () {},
                  controller: TextEditingController(),
                  mandatory: false,
                  labelText: 'Punkte',
                  hintText: '2,5',
                ),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.calculator, size: 40),
                onPressed: () {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: () {}, child: const Text('Abbrechen')),
              OutlinedButton(onPressed: () {}, child: const Text('Übernehmen')),
            ],
          )
        ]),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
    );
  }
}
